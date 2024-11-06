import gvsoc.systree

class MyPowerSupply(gvsoc.systree.Component):
    def __init__(self, parent: gvsoc.systree.Component, name: str):

        super().__init__(parent, name)

        self.add_sources(['my_power_supply.cpp'])

    def i_INPUT(self) -> gvsoc.systree.SlaveItf:
        return gvsoc.systree.SlaveItf(self, 'input', signature='io')

    def o_POWER_CTRL(self, itf: gvsoc.systree.SlaveItf):
        self.itf_bind('power_ctrl', itf, signature='wire<int>')

    def o_VOLTAGE_CTRL(self, itf: gvsoc.systree.SlaveItf):
        self.itf_bind('voltage_ctrl', itf, signature='wire<int>')