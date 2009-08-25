module CalculateBusinessDays
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def business_days_from_now(num, start_date=Date.today)
      #Turn the start date into a number, i.e. Monday = 1
       start_day_of_week = start_date.cwday

       ans, i = 0, 0

       weeks = num / 5.0

       temp_num = num > 5 ? 5 : num

       begin
        ans += days_to_adjust(start_day_of_week,temp_num, i)
        i += 1
        weeks -= 1.0
        temp_num = (weeks >= 1) ? 5 : num % 5
      end while weeks > 0

      days_from_now = start_date + num + ans

    end

    def days_to_adjust(start_day_of_week, num, i)
       ansr = 0
       case start_day_of_week
       when 1
         if 5 == num then ansr += 2 end
       when 2
         if (4..5).include?(num) then ansr += 2 end
       when 3
         if (3..5).include?(num) then ansr += 2 end
       when 4
         if (2..5).include?(num) then ansr += 2 end
       when 5
         ansr += 2
       when 6
         i > 0 ? ansr += 2 : ansr += 1 
       when 7
         if i >= 1 then ansr += 2 end
       end
       return ansr
    end
  end
end

ActiveRecord::Base.send :include, CalculateBusinessDays
