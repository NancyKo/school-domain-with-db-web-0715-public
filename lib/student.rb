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

  def self.new_from_db(row)
    new_student = new
    # binding.pry
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.tagline = row[2]
    new_student.github = row[3]
    new_student.twitter = row[4]
    new_student.blog_url = row[5]
    new_student.image_url = row[6]
    new_student.biography = row[7]
    # binding.pry
    new_student
  end

  def self.find_by_name(name)
    # binding.pry
    sql = """ SELECT * FROM students WHERE name = ? """
    results = DB[:conn].execute(sql, name)
    results.map {|row| self.new_from_db(row) }.first
  end

  def update 
    sql = """
      UPDATE students
      SET name=?, tagline=?, github=?, twitter=?, blog_url=?, image_url=?, biography=?
      WHERE id=?"""
    DB[:conn].execute(sql, name, tagline, github, twitter, blog_url, image_url, biography, id)
  end

  def persisted?
    !!id
  end

  def save 
    persisted? ? update : insert
  end

end