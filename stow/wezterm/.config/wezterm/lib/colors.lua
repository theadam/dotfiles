local scheme = require 'lib/colors/palenightfall'

return {
  apply = function(config)
    config.colors = scheme.colors()
    config.window_frame = scheme.window_frame()
  end
}
