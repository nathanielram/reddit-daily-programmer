# Challenge #201 [Practical Exercise]: Get Your Priorities Straight (2015-02-11)
# from reddit.com/r/dailyprogrammer

class DoublePriorityQueue

  def initialize(queue=[])
    @queue = queue
  end

  def enqueue(obj, priority_a, priority_b)
    @queue.push [obj, priority_a, priority_b]
  end

  def dequeue_a
    @queue.sort_by! { |priority| priority[1] }.reverse!.delete_at(0)
  end

  def dequeue_b
    @queue.sort_by! { |priority| priority[2] }.reverse!.delete_at(0)
  end

  def count
    @queue.size
  end

  def clear
    @queue = []
  end

end

#dpq = DoublePriorityQueue.new [["one",2.3,3.1],["two",5.7,6.2],["three",1.5,7.5]]
dpq = DoublePriorityQueue.new
dpq.enqueue "one", 2.3, 3.1
dpq.enqueue "two", 5.7, 6.2
dpq.enqueue "three", 1.5, 7.5
p dpq.count
p dpq.dequeue_a
p dpq.dequeue_b
p dpq.count
dpq.clear
p dpq.count