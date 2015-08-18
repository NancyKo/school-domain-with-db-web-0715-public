require 'pry'
class Student
attr_accessor :id, :name, :tagline, :github, :twitter, :blog_url, :image_url, :biography
  
  def initialize
    @id = id
    @name = name
    @tagline = tagline
    @github = github
    @twitter = twitter
    @blog_url = blog_url
    @image_url = image_url
    @biography = biography
  end  

  def self.create_table
    sql = """CREATE TABLE students (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            name TEXT,
            tagline TEXT,
            github TEXT, 
            twitter TEXT, 
            blog_url TEXT,
            image_url TEXT,
            biography TEXT);"""
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students;"
    DB[:conn].execute(sql)
  end

  def insert 
    sql = """INSERT INTO students 
            (name, tagline, github, twitter, blog_url, image_url, biography) 
            VALUES (?, ?, ?, ?, ?, ?, ?); """
    DB[:conn].execute(sql, name, tagline ,github, twitter, blog_url, image_url, biography)
    sql = """SELECT last_insert_rowid() FROM students"""
    id = DB[:conn].execute(sql)
    self.id = id.length
  end

end