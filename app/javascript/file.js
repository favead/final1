console.log($("input[name = 'search']"))

$("input").on('input',function () {
	console.log(this.val())
});