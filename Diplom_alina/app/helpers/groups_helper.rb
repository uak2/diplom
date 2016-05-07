module GroupsHelper
  def getSubdivisions()
    res = []
    Subdivision.all.each{|s| res << [ "#{s.chairisting}(#{s.institution})", s.id]}
    return res
  end

  def getTypeSubdivisions
    res = []
    TypeSubdivision.all.each{|ts| res << [ts.title, ts.id]}
    return res
  end
end
