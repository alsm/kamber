# Kamber

This is my fork of [kamber](https://github.com/f/kamber)

Kamber is a blog server based on [Kemal](http://github.com/sdogruyol/kemal).

> This is not a static blog generator, **it's a static blog server**. It _doesn't require_ any other HTTP servers. It uses Crystal and Kemal to generate HTML and also serve it.

## Background

Seeing the original kamber project and having just started looking at [crystal](http://crystal-lang.org) adapting it for my needs seemed like the perfect way to learn.

## Getting started

I'm assuming you already have a working Crystal installation, have cloned this repo and run `shards install`

First thing you'll need to do is create a `config.yml` file in the kamber directory, this contains the configuration information kamber needs.

```yaml
port: 3000 #The port we are going to serve the blog on
title: Blogtastic #The name of your blog
description: Random thoughts from the depths #Subtitle/description for your blog
posts_dir: ./posts/ #The directory where the files for your posts can be found
production: false #Is kemal running in production mode (main difference is where logging goes)
ssl:
  chain_file: chainfile.pem #TLS cert chain file in pem format
  key_file: keyfile.pem #TLS key file in pem format
```

`title`, `description`, `port` and `posts_dir` are all required fields. `production` and `ssl` are optional.

That's enough to get it going, but all you'll see is a nice blank page 😀

Posts are YAML files in the `posts_dir` directory and also have a fixed format of fields

```yaml
type: post #The other post types from kamber are still available too
title: Frist Post #title of the post
subtitle: Getting going #subtitle for the post
date: 2016-03-07 #date of publication
author: me #name of the author of the post, can be html
content: | #this is a string that should be written in Markdown, this example uses a block string to make it easier to layout.
  ##Lots of **content**!!

  _even more content!!_
```

kamber doesn't monitor the posts directory so you will need to restart it to get it to reload any changes.