require "yaml"

def Time.new(pull : YAML::PullParser)
  Time.parse(pull.read_scalar, "%F")
end

class Posts
  include Comparable(self)

  YAML.mapping({
    post_type: {type: String, key: "type"},
    title:     String,
    subtitle:  String,
    date:      Time,
    author:    String,
    content:   String,
    link:      {type: String, default: ""},
    tags:      {type: Array(String), default: [] of String},
  })

  def <=>(other : self)
    date <=> other.date
  end
end

def read_posts(dir)
  posts = [] of Posts
  Dir.entries(dir).each do |file|
    filename = File.join(dir, file)
    if File.file?(filename) && File.extname(filename) != ".draft"
      begin
        posts << Posts.from_yaml(File.read(filename))
      rescue ex
        puts ex.message
      end
    end
  end
  posts.sort.reverse
end
