$(document).ready(function () {
    $('#dataTables-example').DataTable({
        responsive: true,
        language: {
            "decimal": "",
            "emptyTable": "Không có dữ liệu",
            "info": "",
            "infoEmpty": "",
            "infoFiltered": "(filtered from _MAX_ total entries)",
            "infoPostFix": "",
            "thousands": ",",
            "lengthMenu": "Hiển thị _MENU_ dòng",
            "loadingRecords": "Đang tải dữ liệu...",
            "processing": "Đang xử lý...",
            "search": "Tìm kiếm:",
            "zeroRecords": "Không có dữ liệu tương ứng",
            "paginate": {
                "first": "|<<",
                "last": ">>|",
                "next": ">",
                "previous": "<"
            },
            "aria": {
                "sortAscending": ": activate to sort column ascending",
                "sortDescending": ": activate to sort column descending"
            }
        },
        order: [],
        paging: true,
        columnDefs: [
        	{ targets: 'id-col', width: 15, "orderable": true},
        	{ targets: 'avatar-col', "orderable": false, width: 100 },
        	{ targets: 'pages-col', width: 60 },
        	{ targets: 'status-col', width: 68, "orderable": false },
        	{ targets: 'category-col', "orderable": false },
        	{ targets: 'options-col', "orderable": false, width: 150 },
            { width: 350, targets: 'short-des-col', "orderable": false },
            { targets: 'name-col', "orderable": true, width: 180 },
            { targets: 'email-col', "orderable": true, width: 180 },
            { targets: 'created-date-col', "orderable": true, width: 120 },
            { targets: 'slide-col', "orderable": false, width: 500},
            { targets: 'prices-col', "orderable": true, width: 150}
        ]

    });
    
    $('#saveMsg').fadeOut(5000);
});

function deleteCategory(categoryId){
	$(document).ready(function(){
		$('#deleteFormModal').attr('action', "/admin/delete-category/" + categoryId);
	});
}

function deleteProduct(productId){
	$(document).ready(function(){
		$('#deleteFormModal').attr('action', "/admin/delete-book/" + productId);
	});
}

function deleteNews(newsId){
	$(document).ready(function(){
		$('#deleteFormModal').attr('action', "/admin/delete-news/" + newsId);
	});
}

function deleteContact(contactId){
	$(document).ready(function(){
		$('#deleteFormModal').attr('action', "/admin/delete-contact/" + contactId);
	});
}

function deleteSlide(slideId){
	$(document).ready(function(){
		$('#deleteFormModal').attr('action', "/admin/delete-slide/" + slideId);
	});
}

function deleteOrder(orderId){
	$(document).ready(function(){
		$('#deleteFormModal').attr('action', "/admin/delete-order/" + orderId);
	});
}