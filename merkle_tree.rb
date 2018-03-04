require "digest/md5"

def make_merkle_tree(data_list)
  loop do
    hash_list = data_list.map {|data| Digest::MD5.hexdigest(data) }
    hash_set_list = make_set(hash_list)
    data_list = integrate_hash(hash_set_list)
    break if data_list.size == 1
  end
  data_list.first
end

def make_set(hash_list)
  hash_list.each_slice(2).to_a
end

def integrate_hash(hash_set_list)
  hash_set_list.inject([]) do |integrated_data_list, hash_set|
    hash_set << hash_set.first if hash_set.size < 2
    integrated_data_list << "#{hash_set[0]}#{hash_set[1]}"
  end
end