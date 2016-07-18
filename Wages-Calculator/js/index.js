// '.tbl-content' consumed little space for vertical scrollbar, scrollbar width depend on browser/os/platfrom. Here calculate the scollbar width .
$(window).on("load resize ", function() {
  var scrollWidth = $('.tbl-content').width() - $('.tbl-content table').width();
  $('.tbl-header').css({'padding-right':scrollWidth});
}).resize();


function deleteCheck() {
	alert("Do you wanna delete this?");
	location.href = "index.jsp";
}
//function deleteCreate() {
//self.window.alert("Delete");
//location.href = "index.jsp";
//}