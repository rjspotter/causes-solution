# The challenge is to determine the friend network of a word ('causes' for example) in the word list found in word.list
#
# Words are Strings
class String

  # strings are friends if they have a Lev distance <= 1
  def friend?(string)
    # the base difference is defined by the difference of length
    difference = (self.length - string.length).abs
    # increment over each letter in the string stopping as soon as we hit the end of the shorter string
    run_size,i = ((self.length > string.length) ? string.length : self.length) - 1, 0
    # We want to return as soon as we know the distance is > 1 not know the distance.
    # using while instead of upto so the loop gets skipped if length difference > 1
    while (difference < 2 && i <= run_size) do
      # The difference gets bigger the more characters that are not the same
      difference += (self[i] == string[i]) ? 0 : 1
      i += 1
    end
    difference < 2
  end

end


# A friend network is the friends of a word and their friends and their friends et al
class FriendNetwork

  # state holders 
  # friends have had thier friends found
  # hits are friends that haven't had thier friends found
  # haystack is the un-matched list
  attr_accessor :friends, :hits, :haystack

  def initialize(seed = '', hay = [])
    # load the haystack, setup the seed as the first hit, initialize friends as empty
    @haystack,@hits,@friends,@st = hay,[seed],[],Time.now.to_i
    # using a while loop because we want to keep going until no more hits are found
    while @hits.length > 0 do
      # get the value we're going to process, remove it from the hits, add it to the finished friends
      @friends << working = @hits.pop
      new_hits = get_hits(working)
      # add the new hits to the hits stack
      @hits += new_hits
      # remove the new hits from the haystack
      @haystack -= new_hits
      puts "working on #{working}, #{hits.length} hits to go, haystack is #{haystack.length} long"
    end
    # remove the seed from the friends list
    puts (Time.now.to_i - @st).to_s + " seconds run time"
    @friends -= [seed]
  end

  def get_hits(index)
    haystack.select {|x| index.friend? x}
  end
  

end
