import pulp.snitch.snitch_core
from pulp.snitch.snitch_isa import *
from cpu.iss.isa_gen.isa_rvv import *
import memory.memory
import vp.clock_domain
import interco.router
import utils.loader.loader
import gvsoc.systree
import gvsoc.runner
from elftools.elf.elffile import *


GAPY_TARGET = True

class Soc(gvsoc.systree.Component):

    def __init__(self, parent, name, parser):
        super().__init__(parent, name)

        [args, __] = parser.parse_known_args()

        binary = args.binary

        ico = interco.router.Router(self, 'ico')

        mem = memory.memory.Memory(self, 'mem', size=0x10000000, width_log2=-1)
        ico.add_mapping('mem', base=0x00000000, remove_offset=0x00000000, size=0x10000000)
        self.bind(ico, 'mem', mem, 'input')

        fastest_mem = memory.memory.Memory(self, 'fastest_mem', size=0x10000, width_log2=-1)
        latency_mem = memory.memory.Memory(self, 'latency_mem', size=0x10000, width_log2=-1)
        narroww_mem = memory.memory.Memory(self, 'narroww_mem', size=0x10000, width_log2=1)
        slowest_mem = memory.memory.Memory(self, 'slowest_mem', size=0x10000, width_log2=0)
        
        ico.add_mapping('fastest_mem', base=0x10000000, remove_offset=0x10000000, size=0x10000)
        ico.add_mapping('latency_mem', base=0x10010000, remove_offset=0x10010000, size=0x10000, latency=2)
        ico.add_mapping('narroww_mem', base=0x10020000, remove_offset=0x10020000, size=0x10000)
        ico.add_mapping('slowest_mem', base=0x10030000, remove_offset=0x10030000, size=0x10000, latency=2)

        self.bind(ico, 'fastest_mem', fastest_mem, 'input')
        self.bind(ico, 'latency_mem', latency_mem, 'input')
        self.bind(ico, 'narroww_mem', narroww_mem, 'input')
        self.bind(ico, 'slowest_mem', slowest_mem, 'input')
        
        host = pulp.snitch.snitch_core.Spatz(self, 'host', isa='rv32imfdcv')

        self.bind(host, 'fetch', ico, 'input')
        self.bind(host, 'data', ico, 'input')

        loader = utils.loader.loader.ElfLoader(self, 'loader', binary=binary)
        self.bind(loader, 'out', ico, 'input')
        self.bind(loader, 'start', host, 'fetchen')
        self.bind(loader, 'entry', host, 'bootaddr')

        
        self.bind(host, 'vlsu_0', ico, 'input')
        self.bind(host, 'vlsu_1', ico, 'input')
        self.bind(host, 'vlsu_2', ico, 'input')
        self.bind(host, 'vlsu_3', ico, 'input')

class Rv64(gvsoc.systree.Component):

    def __init__(self, parent, name, parser, options):

        super().__init__(parent, name, options=options)

        clock = vp.clock_domain.Clock_domain(self, 'clock', frequency=100000000)
        soc = Soc(self, 'soc', parser)
        clock.o_CLOCK    ( soc.i_CLOCK     ())

class Target(gvsoc.runner.Target):

    def __init__(self, parser, options):
        super(Target, self).__init__(parser, options,
            model=Rv64, description="RV64 virtual board")
