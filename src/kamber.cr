require "./kamber/config"
require "./kamber/posts"

require "markdown"
require "yaml"
require "kemal"
require "openssl"
require "http/server"

def post_item(name)
  $posts.each do |post|
    if post.post_type == "post" && post.title.downcase.gsub(" ", "_") == name
      return render("views/post.ecr")
    end
  end
  puts "Didn't find post for #{name}"
end

$config = Config.from_yaml(File.read("config.yml"))

if $config.ssl.has_key?("chain_file") && $config.ssl.has_key?("key_file")
  puts "loading ssl conf"
  ssl_context = OpenSSL::SSL::Context.new
  ssl_context.certificate_chain = $config.ssl["chain_file"]
  ssl_context.private_key = $config.ssl["key_file"]
  puts "ssl conf enabled"
  puts ssl_context
  Kemal.config.ssl = ssl_context
end

Kemal.config.port = $config.port
Kemal.config.serve_static = false
Kemal.config.env = "production" if $config.production

$posts = read_posts($config.posts_dir)

module Kamber
  get "/" do
    render("views/index.ecr")
  end

  get "/style/:path" do |env|
    env.response.content_type = "text/css"
    File.read("static/css/" + env.params.url["path"] as String)
  end

  get "/script/:path" do |env|
    env.response.content_type = "application/javascript"
    File.read("static/js/" + env.params.url["path"] as String)
  end

  get "/posts/:post" do |env|
    puts "posts"
    post_item(env.params.url["post"] as String)
  end

  get "/tags/:tags" do |env|
    tags = (env.params.url["tags"] as String).split(',')
  end
end
