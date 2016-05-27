module Webapp::ApplyRecordsHelper
      def apply_records_infos
        @hospitals = Hospital.all
      end
end
