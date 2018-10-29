LINUX_VERSION_EXTENSION = "-voyager"

COMPATIBLE_MACHINE = "voyager"

KERNEL_MODULE_AUTOLOAD += " \
    ast_adc \
    pmbus_core \
    pfe3000 \
"

KERNEL_MODULE_PROBECONF += "                    \
 i2c-mux-pca954x                                \
"

module_conf_i2c-mux-pca954x = "options i2c-mux-pca954x ignore_probe=1"
