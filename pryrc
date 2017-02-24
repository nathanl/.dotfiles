# No customizations yet
class Object
  def method_ancestry(method_name)
    method_ancestors = []
    method = method(method_name)
    while method
      method_ancestors << [method.owner, method.source_location]
      method = method.super_method
    end
    method_ancestors
  end
end
