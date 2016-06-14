<!-- AJAX通用写法 -->
$.ajax({
  url: '<%= api_favorite_job_path(params[:id]) %>',
  type: 'DELETE',
  success: function() {
    $('#favorite_job > span').html('收藏职位');
    $('#favorite_job > img').remove();
    $('#favorite_job').prepend( '<%= image_tag "star_black.png" %>');
    $('#favorite_job').attr('class', 'no_favor');
    $('#favorite_job').off();
  },
  error: function() {
    alert('删除失败。')
  }
});

<!-- 返回通用格式 -->
if favorite_job.destroy
  render json: {
             success: true,
             info: '取消收藏成功！'
         }, status: 200
else
  render json: {
             success: false,
             info: '取消收藏失败'
         }, status: 403
end
