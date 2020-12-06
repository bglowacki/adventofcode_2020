class CustomCustoms
  def self.count_yes_answers(input:)
    groups = input.split("\n\n")
    groups.map! {|group| group.gsub("\n", "").split("").uniq.count}
    groups.inject(&:+)
  end
end

pp CustomCustoms.count_yes_answers(input: File.read("input.txt"))
