# Hash maps could accommodate various data types for keys like
# numbers, strings, and even other hashes.
# But for this project, only handle keys of type strings.

class Node

  attr_accessor :value, :key, :next_node

  def initialize(key, value)
    @value = value
    @key = key
    @next_node = nil
  end
end

class Bucket

  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def push(node)
    @tail.next_node = node unless @tail == nil
    @tail = node
    @head = node if @head == nil
  end

  def get(key)
    node = @head
    until node == nil
      return node.value if node.key == key
      node = node.next_node
    end
    nil
  end

  def has(key)
    node = @head
    until node == nil
      return true if node.key == key
      node = node.next_node
    end
    false
  end

  def remove(key)
    deleted = nil
    if key == @head.key
      deleted = @head
      @head = @head.next_node
    elsif key == @tail.key
      node = self.previous(key)
      deleted = node.next_node
      node.next_node = nil
      @tail = node
    else
      node = self.previous(key)
      deleted = node.next_node
      node.next_node = node.next_node.next_node
    end
    deleted
  end

  def size
    node = @head
    size = 0
    until node == nil
      size += 1
      node = node.next_node
    end
    size
  end

  def keys
    self.reduce([]) { |keys, node| keys << node.key }
  end

  def values
    self.reduce([]) { |values, node| values << node.value }
  end

  def entries
    res = self.reduce("") { |entries, node| entries += "[#{node.key}: #{node.value}]; " }
  end

  private

  def reduce(initial_value)
    node = @head
    accamulator = initial_value

    until node == nil
      accamulator = yield(accamulator, node)
      node = node.next_node
    end

    accamulator
  end

  def previous(key)
    node = @head
    until node.next_node.key == key
      node = node.next_node
    end
    node
  end


end

class HashMap

  def initialize
    @size = 16
    @buckets = Array.new(16)
    @buckets = @buckets.map { |bucket| bucket = Bucket.new }
  end

  def set(key, value)
    node = Node.new(key, value)
    self.put_to_bucket(node)
    self.increase_copacity if self.full_buckets / @size >= 0.75
  end

  def get(key)
    index = self.index(key)
    @buckets[index].get(key)
  end

  def has(key)
    index = self.index(key)
    @buckets[index].has(key)
  end

  def remove(key)
    begin
      index = self.index(key)
      raise IndexError if index.negative? || index >= @buckets.length
    rescue IndexError=>e
      puts "Error: #{e}"
    else
      @buckets[index].remove(key)
    end
  end

  def length
    @buckets.reduce(0) { |size, bucket| size += bucket.size }
  end

  def clear
    self.initialize
  end

  def keys
    @buckets.reduce([]) { |keys, bucket| keys << bucket.keys }
  end

  def values
    @buckets.reduce([]) { |values, bucket| values << bucket.values }
  end

  def entries
    @buckets.each { |bucket| print bucket.entries unless bucket == nil }
    print "\n"
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def index(key)
    hash = self.hash(key)
    hash % @size-1
  end

  def full_buckets
    @buckets.count { |bucket| bucket.head != nil }
  end

  def put_to_bucket(node, buckets=@buckets)
    index = self.index(node.key)
    buckets[index].push(node)
    buckets[index]
  end

  def increase_copacity
    new_buckets = Array.new(self.size+1)
    self.size = self.size+1
    self.buckets.each do |bucket|
      node = bucket.head
      until node == nil do
         self.put_to_bucket(node, new_buckets)
      end
    end
    self.buckets = new_buckets
  end

end

#tests

values = Array.new(10) { rand(1..100) }
keys = word = File.readlines('./hangman/google-10000-english-no-swears.txt').shuffle[0..9].map{ |word| word.chomp}
p keys, values


map = HashMap.new
map.entries

i=0
for i in 0..9
   map.set(keys[i], values[i])
end
map.entries

p map.get(keys[5])
p map.has(keys[5])

p map.keys
p map.values

p map.length

p map.remove("")
map.entries

map.clear
p map
