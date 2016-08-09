/********************** 时间插件限制 **********************/
    function endBack(datestr, begin_id, end_id) {
      var begin_at = Date.parse($('#' + begin_id).val()),
          end_at = Date.parse(datestr)

      begin_at = begin_at ? begin_at : 0

      if(begin_at > end_at) {
        FailMask('body', '结束时间不能小于开始时间。')
      } else {
        $('#' + end_id).val(datestr)
        $("#datePage").hide();
        $("#dateshadow").hide();
      }
    }

    function beginBack(datestr, begin_id, end_id) {
      var begin_at = Date.parse(datestr),
          end_at = Date.parse($('#' + end_id).val())

      end_at = end_at ? end_at : Number.POSITIVE_INFINITY

      if(begin_at > end_at) {
        FailMask('body', '开始时间不能大于结束时间。')
      } else {
        $('#' + begin_id).val(datestr)
        $("#datePage").hide();
        $("#dateshadow").hide();
      }
    }
