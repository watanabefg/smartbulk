require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  def setup
  end
  
  test "should not save record without any" do
    record = Record.new
    assert_not record.save, "Saved the record without user_id,weight,fatPer"
  end
  
  test "should be valid" do
    record = Record.new(:user_id => 298486374, :weight => 62.0, :fatPer => 12.7)
    assert record.valid?, "not valid"
  end
  
end
