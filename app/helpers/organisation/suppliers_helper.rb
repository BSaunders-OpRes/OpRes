module Organisation::SuppliersHelper
  def titleize_last_alpha(key)
    dup_key = key.dup
    if dup_key!='Other'
      dup_key[dup_key.size-1] = dup_key[dup_key.size-1].capitalize
    end
    dup_key
  end
end
