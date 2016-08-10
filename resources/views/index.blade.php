@extends('master_index')
@section('content')
<!--Carousell-->
	<div id="myCarousel" class="carousel slide wow fadeInDown" data-wow-duration="1000ms" data-wow-delay="300ms" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class=""></li>
        <li data-target="#myCarousel" data-slide-to="1" class=""></li>
        <li data-target="#myCarousel" data-slide-to="2" class="active"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item ">
          <img class="first-slide" src="{{ URL::asset('images/index1.jpg')}}" alt="First slide">
          <div class="container">
            <div class="carousel-caption">
              <h1> APIKES IMELDA</h1>
             
            </div>
          </div>
        </div>
        <div class="item active">
          <img class="second-slide" src="{{ URL::asset('images/index5.jpg')}}" alt="Second slide">
          <div class="container">
            <div class="carousel-caption">
              <h1>AKADEMI  PEREKAM MEDIK DAN INFOKES (APIKES) IMELDA</h1>
      
            </div>
          </div>
        </div>
        <div class="item">
          <img src="{{ URL::asset('images/index3.jpg')}}" alt="Third slide" height="578" class="third-slide">
          <div class="container">
            <div class="carousel-caption">
              <h1>Medical Record</h1>

            </div>
          </div>
        </div>
		
		
		
		
      </div>
      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
	<!--End Of Carousell-->
	@endsection