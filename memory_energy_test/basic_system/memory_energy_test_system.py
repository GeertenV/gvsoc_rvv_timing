import gvsoc.systree
import gvsoc.runner

import cpu.iss.riscv
import memory.memory
import vp.clock_domain
import interco.router
import utils.loader.loader
import gdbserver.gdbserver

import my_power_supply


GAPY_TARGET = True

class Soc(gvsoc.systree.Component):

    def __init__(self, parent, name, parser):
        super().__init__(parent, name)

        # Parse the arguments to get the path to the binary to be loaded
        [args, __] = parser.parse_known_args()

        binary = args.binary

        ico = interco.router.Router(self, 'ico')

        mem = memory.memory.Memory(self, 'mem', size=0x00100000, power_trigger=True)
        ico.add_mapping('mem', base=0x00000000, remove_offset=0x00000000, size=0x00100000)
        self.bind(ico, 'mem', mem, 'input')

        power_unit = my_power_supply.MyPowerSupply(self, 'power_unit')
        ico.add_mapping('power_unit', base=0x00100000, remove_offset=0x00100000, size=0x00001000)
        self.bind(ico, 'power_unit', power_unit, 'input')
        self.bind(power_unit, 'power_ctrl', mem, 'power_supply')
        self.bind(power_unit, 'voltage_ctrl', mem, 'voltage')

        host = cpu.iss.riscv.Riscv(self, 'host', isa='rv64imafdc')
        self.bind(host, 'fetch', ico, 'input')
        self.bind(host, 'data', ico, 'input')

        loader = utils.loader.loader.ElfLoader(self, 'loader', binary=binary)
        self.bind(loader, 'out', ico, 'input')
        self.bind(loader, 'start', host, 'fetchen')
        self.bind(loader, 'entry', host, 'bootaddr')

        mem.add_properties({
            "background": {
                "dynamic": {
                    "type": "linear",
                    "unit": "W",
                
                    "values": {
                        "25": {
                            "1.2": {
                                "any": 0.0001
                            }
                        }
                    }
                },
                "leakage": {
                    "type": "linear",
                    "unit": "W",
                
                    "values": {
                        "25": {
                            "1.2": {
                                "any": 0.000001
                            }
                        }
                    }
                }
            },
            "read_32": {
                "dynamic": {
                    "type": "linear",
                    "unit": "pJ",
                
                    "values": {
                        "25": {
                            "1.2": {
                                "any": 1.5
                            }
                        }
                    }
                }
            },
            "write_32": {
                "dynamic": {
                    "type": "linear",
                    "unit": "pJ",
                
                    "values": {
                        "25": {
                            "1.2": {
                                "any": 2.5
                            }
                        }
                    }
                }
            }
        })

        gdbserver.gdbserver.Gdbserver(self, 'gdbserver')


# This is a wrapping component of the real one in order to connect a clock generator to it
# so that it automatically propagate to other components
class Rv64(gvsoc.systree.Component):

    def __init__(self, parent, name, parser, options):

        super().__init__(parent, name, options=options)

        clock = vp.clock_domain.Clock_domain(self, 'clock', frequency=100000000)
        soc = Soc(self, 'soc', parser)
        clock.o_CLOCK    (soc.i_CLOCK    ())




# This is the top target that gapy will instantiate
class Target(gvsoc.runner.Target):

    def __init__(self, parser, options):
        super(Target, self).__init__(parser, options,
            model=Rv64, description="RV64 virtual board")

