require 'test_helper'

class CalculateBusinessDaysTest < ActiveSupport::TestCase
  
  class Order < ActiveRecord::Base
  end
  
  def test_business_from_days_from_now
    assert_equal "Wed, 02 Sep 2009".to_date, Order.business_days_from_now(3, "Fri, 28 Aug 2009".to_date)
  end
end
