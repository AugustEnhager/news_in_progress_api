# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  enum role: { registered_user: 0, journalist: 2, editor: 3, subscriber: 4 }

  has_and_belongs_to_many :articles, join_table: 'articles_authors', foreign_key: 'author_id'


end
 