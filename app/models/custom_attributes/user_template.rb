module CustomAttributes
  class UserTemplate < CustomAttribute
    def need_targetable?
      false
    end
  end
end
