<!DOCTYPE html>
<html lang="en">

<?php
require_once("../controller/model/sessionadmin.php");
include ("AdminLayOut/header.php");
?>
<link rel="stylesheet" type='text/css' href='library/css/jquery.dataTables.min.css' />
<link rel="stylesheet" type='text/css' href='../css/alertify.min.css' />
<link rel="stylesheet" type='text/css' href='../css/themes/default.min.css' />

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <?php include ("AdminLayOut/navigasi.php"); ?>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Dashboard <small><?php print $_SESSION['username']; ?></small>
                        </h1>
                        <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12">
                        <div class="alert alert-info alert-dismissable">
                            <i class="fa fa-info-circle"></i>  <strong>Welcome</strong> <?php print $_SESSION['username']; ?> 
                        </div>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-envelope fa-2x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <strong id="total"></strong>
                                        <div>Total Pesan</div>
                                    </div>
                                </div>
                            </div>
							<div class="panel-body">
								<table class="table table-striped" id="tblmsg">
									<thead>
										<tr>
											<th>Nama</th>
											<th>E-mail</th>
											<th>Nomor Kontak</th>
											<th>Nama Perusahaan</th>
											<th>Pesan</th>
										</tr>
									</thead>
								</table>
							</div>
                           
						   
                        </div>
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
	
	<!--modal-->
	<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel">
		  <div class="modal-dialog modal-sm">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="exampleModalLabel">Detail Pesan</h4>
			</div>
			 <div class="modal-body">
			 
			 </div>
			  <div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
			</div>
		  </div>
	</div>
	<!--end modal-->
	
<script type='text/javascript' src='library/js/jquery.dataTables.min.js'></script>
<script type='text/javascript' src='../js/alertify.min.js'></script>

<script type="text/javascript">
var strhtml='';
var loadcountmessage = function(){
	$.post("getcountmessage.php",function(data,status){
		$('#total').text(data.data);
	},'json');
}

var loadmsg = function(){
	$.post('getnewmessage.php',function(data,status){
		for(var i=0;i<data.data.length;i++){
			strhtml+='<li class="message-preview">';
			strhtml+='<a href="read.php?id='+data.data[i].Id+'">';
            strhtml+='<div class="media">';
            strhtml+='<div class="media-body">';
            strhtml+='<h5 class="media-heading"><strong>'+data.data[i].name+'</strong>';
            strhtml+='</h5>';
            strhtml+='<p class="small text-muted"><i class="fa fa-clock-o"></i> '+ data.data[i].datereceive+'</p>';
            strhtml+='<p>'+data.data[i].message+'</p>';
            strhtml+='</div>'
            strhtml+='</div>';
            strhtml+='</a>';
            strhtml+='</li>';
		}
		$('.message-dropdown').append(strhtml);
	},'json');
}
$(document).ready(function(){
	loadmsg();
	loadcountmessage();
	setInterval(function () {
               loadcountmessage();}, 2000);
	
	var gentable=$('#tblmsg').DataTable({
		'info':false,
		'ajax':'getmessage.php',
		'columns':[
				{"data": "name","bSortable": false},
				{"data":"email"},
				{"data":"contactnumber"},
				{"data":"companyname"},
				{"className": "action text-center",
								"data": null,
								"bSortable": false,
								"defaultContent": "" +
								"<div class='btn-group' role='group'>" +
								"<button class='show btn btn-primary btn-xs' data-toggle='modal' data-target='.bs-example-modal-sm'><i class='fa fa-envelope'></i></button>" +
								"<button class='delete btn btn-danger btn-xs' rel='tooltip' data-toggle='tooltip' data-placement='left' title='Hapus'><i class='fa fa-trash-o'></i></button>"+
								"</div>"}
			]
	});
	var sbody = $('#tblmsg tbody');
	sbody.on('click','.show',function(){
		$('.modal-header').find('h4').text('');
		$('.modal-body').text('');
		var data = gentable.row($(this).parents('tr')).data();
		$('.modal-header').find('h4').text('Detail Pesan Dari :'+data.name);
		$('.modal-body').text(data.message);
		
	}).
	on('click','.delete',function(){
		var data = gentable.row($(this).parents('tr')).data();
		alertify.confirm("Konfirmasi","Anda yakin ingin menghapus data?",
		  function(){
			  $.post("deletemsg.php",{'id':data.Id},function(data,status){
						if(data==1){
							alertify.success('Data berhasil dihapus!');
							gentable.ajax.reload();
							loadcountmessage();
						}else{
							alertify.error('Gagal menghapus');
						}
						
					},'json');
								
		  },
		  function(){
			alertify.error('Batal');
		  });
		
	});
//console.log(gentable.fnGetData().length);

});

</script>    
</body>

</html>
