require "yaml"

class Config
  YAML.mapping({
    title:       String,
    description: String,
    port:        Int32,
    posts_dir:   String,
    production:  {type: Bool, default: false},
    ssl:         {type: Hash(String, String), default: {} of String => String},
  })
end
