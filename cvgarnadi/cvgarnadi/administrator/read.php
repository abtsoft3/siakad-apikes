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
                            <li >
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
							<li class="active">Read</li>
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
				<?php
				$data="";
				if(isset($_GET['id'])){
					$Id = $_GET['id'];
					if(preg_match("/^\-?\+?[0-9e1-9]+$/", $Id)){
						if($Id>0){
							$Id = mysql_real_escape_string($Id);
							//update status
							require_once('../controller/model/config.php');
							$updatequery =mysql_query("update leavemessage set status='R' where Id=$Id");
							if($updatequery){
									//get all messages
								$getmsg = mysql_query("select * from leavemessage where Id ='$Id'");
								if($getmsg){
									$data = mysql_fetch_assoc($getmsg); 
								}
							}
							
						}else{
							
						}
					}else{
						false;
					}
				}else{
					false;
				}				
				?>
				
                <div class="row">
                    <div class="col-lg-12 col-md-12">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-envelope"></i>
											Pengirim : <?php print $data['email']; ?>
											
                                    </div>
                                    
                                </div>
                            </div>
							<div class="panel-body">
								<div class="col-lg-6 col-md-6 col-sm-6">
									<label>Nama : <?php print $data['name']; ?></label><p/>
									<label>Nomor Kontak : <?php print $data['contactnumber']; ?></label><p/>
									<label>Nama Perusahaan : <?php print $data['companyname']; ?></label><p/>
									<label>Waktu Kirim : <?php print $data['datereceive']; ?></label>
								</div>
								<div class="col-lg-6 col-md-6 col-sm-6">
								<label>Pesan : <?php print $data['message']; ?></label>
								</div>
							</div>
                            <a href="index.php">
                                <div class="panel-footer">
                                    <span class="pull-left">Kembali</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>						   
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
	

});

</script>    
</body>

</html>
