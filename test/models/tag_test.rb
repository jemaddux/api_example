require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test 'valid tag' do
    tag = Tag.new(name: "help")
    assert tag.valid?
  end

  test 'invalid without name' do
    tag = Tag.new(name: nil)
    refute tag.valid?, 'tag is not valid without a name'
    assert_not_nil tag.errors[:user_id], 'no validation error for name present'
  end
end
