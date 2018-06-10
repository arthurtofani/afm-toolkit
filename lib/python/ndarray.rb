require 'pycall'
include PyCall::Import

class Ndarray
  include PyCall::PyObjectWrapper
  wrap_class PyCall.import_module('numpy').ndarray
end
#PyCall::PyObjectWrapper
