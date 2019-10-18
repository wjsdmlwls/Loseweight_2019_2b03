<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

        
	
    <head>
    
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
        <meta charset="UTF-8" />
        <title>jQuery UI</title>
        </head>
        <script>
        $('#nav nav a').on('click', function(event) {
            $(this).parent().find('a').removeClass('active');
            $(this).addClass('active');
        });

        $(window).on('scroll', function() {
            $('.target').each(function() {
                if($(window).scrollTop() >= $(this).offset().top) {
                    var id = $(this).attr('id');
                    $('#nav nav a').removeClass('active');
                    $('#nav nav a[href=#'+ id +']').addClass('active');
                }
            });
        });
        </script>
        <style>
        * {
		    margin: 0;
		    padding: 0;
		}
		
		#main {
		    width: 75%;
		    float: right;
		}
		
		#main div.target {
		    background: #ccc;
		    height: 400px;
		}
		
		#main div.target:nth-child(even) {
		    background: #eee;
		}
		
		#nav {
		    width: 25%;
		    position: relative;
		}
		
		#nav nav {
		    position: fixed;
		    width: 25%;
		}
		
		#nav a {
		    border-bottom: 1px solid #666;
		    color: #333;
		    display: block;
		    padding: 10px;
		    text-align: center;
		    text-decoration: none;
		}
		
		#nav a:hover, #nav a.active {
		    background: #666;
		    color: #fff;
		}
        </style>

        <body>
        <section id="main">
		    <div class="target" id="1">TARGET 1</div>
		    <div class="target" id="2">TARGET 2</div>
		    <div class="target" id="3">TARGET 3</div>
		    <div class="target" id="4">TARGET 4</div>
		</section>
		<aside id="nav">
		    <nav>
		        <a href="#1" class="active">Menu 1</a>
		        <a href="#2">Menu 2</a>
		        <a href="#3">Menu 3</a>
		        <a href="#4">Menu 4</a>
		    </nav>
		</aside>
        </body>
        </html>
        