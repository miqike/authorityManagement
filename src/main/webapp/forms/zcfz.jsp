<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/jquery/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("input[name='item15Qcs']").focus(
				function() {
					var item2Qcs = $("input[name='item2Qcs']").val();
					var item3Qcs = $("input[name='item3Qcs']").val();
					var item4Qcs = $("input[name='item4Qcs']").val();
					var item5Qcs = $("input[name='item5Qcs']").val();
					var item6Qcs = $("input[name='item6Qcs']").val();
					var item7Qcs = $("input[name='item7Qcs']").val();
					var item8Qcs = $("input[name='item8Qcs']").val();
					var item9Qcs = $("input[name='item9Qcs']").val();
					var item10Qcs = $("input[name='item10Qcs']").val();
					var item11Qcs = $("input[name='item11Qcs']").val();
					var item12Qcs = $("input[name='item12Qcs']").val();
					var item13Qcs = $("input[name='item13Qcs']").val();
					var item14Qcs = $("input[name='item14Qcs']").val();
					if (item2Qcs != null && item2Qcs != "" || item3Qcs != null
							&& item3Qcs != "" || item4Qcs != null
							&& item4Qcs != "" || item5Qcs != null
							&& item5Qcs != "" || item6Qcs != null
							&& item6Qcs != "" || item7Qcs != null
							&& item7Qcs != "" || item8Qcs != null
							&& item8Qcs != "" || item9Qcs != null
							&& item9Qcs != "" || item10Qcs != null
							&& item10Qcs != "" || item11Qcs != null
							&& item11Qcs != "" || item12Qcs != null
							&& item12Qcs != "" || item13Qcs != null
							&& item13Qcs != "" || item14Qcs != null
							&& item14Qcs != "") {
						var a = new Array(item2Qcs, item3Qcs, item4Qcs,
								item5Qcs, item6Qcs, item7Qcs, item8Qcs,
								item9Qcs, item10Qcs, item11Qcs, item12Qcs,
								item13Qcs, item14Qcs);
						var item15Qcs = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item15Qcs +=b ;
								}
						}
						$("input[name='item15Qcs']").val(item15Qcs);
					}

				});
		
		
		$("input[name='item15Qms']").focus(
				function() {
					var item2Qms = $("input[name='item2Qms']").val();
					var item3Qms = $("input[name='item3Qms']").val();
					var item4Qms = $("input[name='item4Qms']").val();
					var item5Qms = $("input[name='item5Qms']").val();
					var item6Qms = $("input[name='item6Qms']").val();
					var item7Qms = $("input[name='item7Qms']").val();
					var item8Qms = $("input[name='item8Qms']").val();
					var item9Qms = $("input[name='item9Qms']").val();
					var item10Qms = $("input[name='item10Qms']").val();
					var item11Qms = $("input[name='item11Qms']").val();
					var item12Qms = $("input[name='item12Qms']").val();
					var item13Qms = $("input[name='item13Qms']").val();
					var item14Qms = $("input[name='item14Qms']").val();
					if (item2Qms != null && item2Qms != "" || item3Qms != null
							&& item3Qms != "" || item4Qms != null
							&& item4Qms != "" || item5Qms != null
							&& item5Qms != "" || item6Qms != null
							&& item6Qms != "" || item7Qms != null
							&& item7Qms != "" || item8Qms != null
							&& item8Qms != "" || item9Qms != null
							&& item9Qms != "" || item10Qms != null
							&& item10Qms != "" || item11Qms != null
							&& item11Qms != "" || item12Qms != null
							&& item12Qms != "" || item13Qms != null
							&& item13Qms != "" || item14Qms != null
							&& item14Qms != "") {
						var a = new Array(item2Qms, item3Qms, item4Qms,
								item5Qms, item6Qms, item7Qms, item8Qms,
								item9Qms, item10Qms, item11Qms, item12Qms,
								item13Qms, item14Qms);
						var item15Qms = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item15Qms +=b ;
								}
						}
						$("input[name='item15Qms']").val(item15Qms);
					}

				});
		
		
		
		$("input[name='item34Qcs']").focus(
				function() {
					var item17Qcs = $("input[name='item17Qcs']").val();
					var item18Qcs = $("input[name='item18Qcs']").val();
					var item19Qcs = $("input[name='item19Qcs']").val();
					var item20Qcs = $("input[name='item20Qcs']").val();
					var item21Qcs = $("input[name='item21Qcs']").val();
					var item22Qcs = $("input[name='item22Qcs']").val();
					var item23Qcs = $("input[name='item23Qcs']").val();
					var item24Qcs = $("input[name='item24Qcs']").val();
					var item25Qcs = $("input[name='item25Qcs']").val();
					var item26Qcs = $("input[name='item26Qcs']").val();
					var item27Qcs = $("input[name='item27Qcs']").val();
					var item28Qcs = $("input[name='item28Qcs']").val();
					var item29Qcs = $("input[name='item29Qcs']").val();
					var item30Qcs = $("input[name='item30Qcs']").val();
					var item31Qcs = $("input[name='item31Qcs']").val();
					var item32Qcs = $("input[name='item32Qcs']").val();
					var item33Qcs = $("input[name='item33Qcs']").val();
					if (item17Qcs != null && item17Qcs != "" || item18Qcs != null
							&& item18Qcs != "" || item19Qcs != null
							&& item19Qcs != "" || item20Qcs != null
							&& item20Qcs != "" || item21Qcs != null
							&& item21Qcs != "" || item22Qcs != null
							&& item22Qcs != "" || item23Qcs != null
							&& item23Qcs != "" || item24Qcs != null
							&& item24Qcs != "" || item25Qcs != null
							&& item25Qcs != "" || item26Qcs != null
							&& item26Qcs != "" || item27Qcs != null
							&& item27Qcs != "" || item28Qcs != null
							&& item28Qcs != "" || item29Qcs != null
							&& item29Qcs != ""|| item30Qcs != null
							&& item30Qcs != ""|| item31Qcs != null
							&& item31Qcs != ""|| item32Qcs != null
							&& item32Qcs != ""|| item33Qcs != null
							&& item33Qcs != "") {
						var a = new Array(item17Qcs, item18Qcs, item19Qcs,
								item20Qcs, item21Qcs, item22Qcs, item23Qcs,
								item24Qcs, item25Qcs, item26Qcs, item27Qcs,
								item28Qcs, item29Qcs,item30Qcs,item31Qcs,item32Qcs,item33Qcs);
						var item34Qcs = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item34Qcs +=b ;
								}
						}
						$("input[name='item34Qcs']").val(item34Qcs);
					}

				});

		
		$("input[name='item34Qms']").focus(
				function() {
					var item17Qms = $("input[name='item17Qms']").val();
					var item18Qms = $("input[name='item18Qms']").val();
					var item19Qms = $("input[name='item19Qms']").val();
					var item20Qms = $("input[name='item20Qms']").val();
					var item21Qms = $("input[name='item21Qms']").val();
					var item22Qms = $("input[name='item22Qms']").val();
					var item23Qms = $("input[name='item23Qms']").val();
					var item24Qms = $("input[name='item24Qms']").val();
					var item25Qms = $("input[name='item25Qms']").val();
					var item26Qms = $("input[name='item26Qms']").val();
					var item27Qms = $("input[name='item27Qms']").val();
					var item28Qms = $("input[name='item28Qms']").val();
					var item29Qms = $("input[name='item29Qms']").val();
					var item30Qms = $("input[name='item30Qms']").val();
					var item31Qms = $("input[name='item31Qms']").val();
					var item32Qms = $("input[name='item32Qms']").val();
					var item33Qms = $("input[name='item33Qms']").val();
					if (item17Qms != null && item17Qms != "" || item18Qms != null
							&& item18Qms != "" || item19Qms != null
							&& item19Qms != "" || item20Qms != null
							&& item20Qms != "" || item21Qms != null
							&& item21Qms != "" || item22Qms != null
							&& item22Qms != "" || item23Qms != null
							&& item23Qms != "" || item24Qms != null
							&& item24Qms != "" || item25Qms != null
							&& item25Qms != "" || item26Qms != null
							&& item26Qms != "" || item27Qms != null
							&& item27Qms != "" || item28Qms != null
							&& item28Qms != "" || item29Qms != null
							&& item29Qms != ""|| item30Qms != null
							&& item30Qms != ""|| item31Qms != null
							&& item31Qms != ""|| item32Qms != null
							&& item32Qms != ""|| item33Qms != null
							&& item33Qms != "") {
						var a = new Array(item17Qms, item18Qms, item19Qms,
								item20Qms, item21Qms, item22Qms, item23Qms,
								item24Qms, item25Qms, item26Qms, item27Qms,
								item28Qms, item29Qms,item30Qms,item31Qms,item32Qms,item33Qms);
						var item34Qms = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item34Qms +=b ;
								}
						}
						$("input[name='item34Qms']").val(item34Qms);
					}

				});
		
		$("input[name='item43Qcs']").focus(
				function() {
					var item15Qcs=$("input[name='item15Qcs']").val();
					var item34Qcs=$("input[name='item34Qcs']").val();
					var a=new Array(item15Qcs,item34Qcs);
					var sum=0;
					for(var i=0;i<a.length;i++){
						if(a[i]!=null&&a[i]!=""){
							var b=parseFloat(a[i]);
							sum+=b;
						}
					}
					$("input[name='item43Qcs']").val(sum);
				});
		
		$("input[name='item43Qms']").focus(
				function() {
					var item15Qms=$("input[name='item15Qms']").val();
					var item34Qms=$("input[name='item34Qms']").val();
					var a=new Array(item15Qms,item34Qms);
					var sum=0;
					for(var i=0;i<a.length;i++){
						if(a[i]!=null&&a[i]!=""){
							var b=parseFloat(a[i]);
							sum+=b;
						}
					}
					$("input[name='item43Qms']").val(sum);
				});
		
		$("input[name='item59Qcs']").focus(
				function() {
					var item45Qcs = $("input[name='item45Qcs']").val();
					var item46Qcs = $("input[name='item46Qcs']").val();
					var item47Qcs = $("input[name='item47Qcs']").val();
					var item48Qcs = $("input[name='item48Qcs']").val();
					var item49Qcs = $("input[name='item49Qcs']").val();
					var item50Qcs = $("input[name='item50Qcs']").val();
					var item51Qcs = $("input[name='item51Qcs']").val();
					var item52Qcs = $("input[name='item52Qcs']").val();
					var item53Qcs = $("input[name='item53Qcs']").val();
					var item54Qcs = $("input[name='item54Qcs']").val();
					var item55Qcs = $("input[name='item55Qcs']").val();
					var item56Qcs = $("input[name='item56Qcs']").val();
					var item57Qcs = $("input[name='item57Qcs']").val();
					var item58Qcs = $("input[name='item58Qcs']").val();
					if (item45Qcs != null && item45Qcs != "" || item46Qcs != null
							&& item46Qcs != "" || item47Qcs != null
							&& item47Qcs != "" || item48Qcs != null
							&& item48Qcs != "" || item49Qcs != null
							&& item49Qcs != "" || item50Qcs != null
							&& item50Qcs != "" || item51Qcs != null
							&& item51Qcs != "" || item52Qcs != null
							&& item52Qcs != "" || item53Qcs != null
							&& item53Qcs != "" || item54Qcs != null
							&& item54Qcs != "" || item55Qcs != null
							&& item55Qcs != "" || item56Qcs != null
							&& item56Qcs != "" || item57Qcs != null
							&& item57Qcs != ""|| item58Qcs != null
							&& item58Qcs != "") {
						var a = new Array(item45Qcs, item46Qcs, item47Qcs,
								item48Qcs, item49Qcs, item50Qcs, item51Qcs,
								item52Qcs, item53Qcs, item54Qcs, item55Qcs,
								item56Qcs, item57Qcs,item58Qcs);
						var item59Qcs = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item59Qcs +=b ;
								}
						}
						$("input[name='item59Qcs']").val(item59Qcs);
					}

				});
		
		
		$("input[name='item59Qms']").focus(
				function() {
					var item45Qms = $("input[name='item45Qms']").val();
					var item46Qms = $("input[name='item46Qms']").val();
					var item47Qms = $("input[name='item47Qms']").val();
					var item48Qms = $("input[name='item48Qms']").val();
					var item49Qms = $("input[name='item49Qms']").val();
					var item50Qms = $("input[name='item50Qms']").val();
					var item51Qms = $("input[name='item51Qms']").val();
					var item52Qms = $("input[name='item52Qms']").val();
					var item53Qms = $("input[name='item53Qms']").val();
					var item54Qms = $("input[name='item54Qms']").val();
					var item55Qms = $("input[name='item55Qms']").val();
					var item56Qms = $("input[name='item56Qms']").val();
					var item57Qms = $("input[name='item57Qms']").val();
					var item58Qms = $("input[name='item58Qms']").val();
					if (item45Qms != null && item45Qms != "" || item46Qms != null
							&& item46Qms != "" || item47Qms != null
							&& item47Qms != "" || item48Qms != null
							&& item48Qms != "" || item49Qms != null
							&& item49Qms != "" || item50Qms != null
							&& item50Qms != "" || item51Qms != null
							&& item51Qms != "" || item52Qms != null
							&& item52Qms != "" || item53Qms != null
							&& item53Qms != "" || item54Qms != null
							&& item54Qms != "" || item55Qms != null
							&& item55Qms != "" || item56Qms != null
							&& item56Qms != "" || item57Qms != null
							&& item57Qms != "" || item58Qms != null
							&& item58Qms != "") {
						var a = new Array(item45Qms, item46Qms, item47Qms,
								item48Qms, item49Qms, item50Qms, item51Qms,
								item52Qms, item53Qms, item54Qms, item55Qms,
								item56Qms, item57Qms,item58Qms);
						var item59Qms = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item59Qms +=b ;
								}
						}
						$("input[name='item59Qms']").val(item59Qms);
					}

				});
		
		$("input[name='item72Qcs']").focus(
				function() {
					var item61Qcs = $("input[name='item61Qcs']").val();
					var item62Qcs = $("input[name='item62Qcs']").val();
					var item65Qcs = $("input[name='item65Qcs']").val();
					var item66Qcs = $("input[name='item66Qcs']").val();
					var item67Qcs = $("input[name='item67Qcs']").val();
					var item68Qcs = $("input[name='item68Qcs']").val();
					var item69Qcs = $("input[name='item69Qcs']").val();
					var item70Qcs = $("input[name='item70Qcs']").val();
					var item71Qcs = $("input[name='item71Qcs']").val();
					if (item61Qcs != null && item61Qcs != "" || item62Qcs != null
							&& item62Qcs != "" || item65Qcs != null
							&& item65Qcs != "" || item66Qcs != null
							&& item66Qcs != "" || item67Qcs != null
							&& item67Qcs != "" || item68Qcs != null
							&& item68Qcs != "" || item69Qcs != null
							&& item69Qcs != "" || item70Qcs != null
							&& item70Qcs != "" || item71Qcs != null
							&& item71Qcs != "" ) {
						var a = new Array(item61Qcs, item62Qcs, item65Qcs,
								item66Qcs, item67Qcs, item68Qcs, item69Qcs,
								item70Qcs, item71Qcs);
						var item72Qcs = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item72Qcs +=b ;
								}
						}
						$("input[name='item72Qcs']").val(item72Qcs);
					}

				});
		
		$("input[name='item72Qms']").focus(
				function() {
					var item61Qms = $("input[name='item61Qms']").val();
					var item62Qms = $("input[name='item62Qms']").val();
					var item65Qms = $("input[name='item65Qms']").val();
					var item66Qms = $("input[name='item66Qms']").val();
					var item67Qms = $("input[name='item67Qms']").val();
					var item68Qms = $("input[name='item68Qms']").val();
					var item69Qms = $("input[name='item69Qms']").val();
					var item70Qms = $("input[name='item70Qms']").val();
					var item71Qms = $("input[name='item71Qms']").val();
					if (item61Qms != null && item61Qms != "" || item62Qms != null
							&& item62Qms != "" || item65Qms != null
							&& item65Qms != "" || item66Qms != null
							&& item66Qms != "" || item67Qms != null
							&& item67Qms != "" || item68Qms != null
							&& item68Qms != "" || item69Qms != null
							&& item69Qms != "" || item70Qms != null
							&& item70Qms != "" || item71Qms != null
							&& item71Qms != "" ) {
						var a = new Array(item61Qms, item62Qms, item65Qms,
								item66Qms, item67Qms, item68Qms, item69Qms,
								item70Qms, item71Qms);
						var item72Qms = 0;
						for (var i = 0; i < a.length; i++) {
								if (a[i] != null && a[i] != ""){
								var b=parseFloat(a[i]);

								item72Qms +=b ;
								}
						}
						$("input[name='item72Qms']").val(item72Qms);
					}

				});
		
		$("input[name='item73Qcs']").focus(
				function() {
					var item59Qcs=$("input[name='item59Qcs']").val();
					var item72Qcs=$("input[name='item72Qcs']").val();
					var a=new Array(item59Qcs,item72Qcs);
					var sum=0;
					for(var i=0;i<a.length;i++){
						if(a[i]!=null&&a[i]!=""){
							var b=parseFloat(a[i]);
							sum+=b;
						}
					}
					$("input[name='item73Qcs']").val(sum);
				});
		
		$("input[name='item73Qms']").focus(
				function() {
					var item59Qms=$("input[name='item59Qms']").val();
					var item72Qms=$("input[name='item72Qms']").val();
					var a=new Array(item59Qms,item72Qms);
					var sum=0;
					for(var i=0;i<a.length;i++){
						if(a[i]!=null&&a[i]!=""){
							var b=parseFloat(a[i]);
							sum+=b;
						}
					}
					$("input[name='item73Qms']").val(sum);
				});
		
		$("input[name='item85Qcs']").focus(
				function() {
					var item75Qcs=$("input[name='item75Qcs']").val();
					var item76Qcs=$("input[name='item76Qcs']").val();
					var item79Qcs=$("input[name='item79Qcs']").val();
					var item80Qcs=$("input[name='item80Qcs']").val();
					var item81Qcs=$("input[name='item81Qcs']").val();
					var item82Qcs=$("input[name='item82Qcs']").val();
					var item83Qcs=$("input[name='item83Qcs']").val();
					var item84Qcs=$("input[name='item84Qcs']").val();
					var a=new Array(item75Qcs,item76Qcs,item79Qcs,item81Qcs,item82Qcs,item83Qcs,item84Qcs);
					var sum=0;
					for(var i=0;i<a.length;i++){
						if(a[i]!=null&&a[i]!=""){
							var b=parseFloat(a[i]);
							sum+=b;
						}
					}
					if(item80Qcs!=null&&item80Qcs!=""){
						var c=parseFloat(item80Qcs);
						sum-=c;
					}
					$("input[name='item85Qcs']").val(sum);
				});
		
		$("input[name='item85Qms']").focus(
				function() {
					var item75Qms=$("input[name='item75Qms']").val();
					var item76Qms=$("input[name='item76Qms']").val();
					var item79Qms=$("input[name='item79Qms']").val();
					var item80Qms=$("input[name='item80Qms']").val();
					var item81Qms=$("input[name='item81Qms']").val();
					var item82Qms=$("input[name='item82Qms']").val();
					var item83Qms=$("input[name='item83Qms']").val();
					var item84Qms=$("input[name='item84Qms']").val();
					var a=new Array(item75Qms,item76Qms,item79Qms,item81Qms,item82Qms,item83Qms,item84Qms);
					var sum=0;
					for(var i=0;i<a.length;i++){
						if(a[i]!=null&&a[i]!=""){
							var b=parseFloat(a[i]);
							sum+=b;
						}
					}
					if(item80Qms!=null&&item80Qms!=""){
						var c=parseFloat(item80Qms);
						sum-=c;
					}
					$("input[name='item85Qms']").val(sum);
				});
		
		$("input[name='item86Qcs']").focus(
				function() {
					var item73Qcs=$("input[name='item73Qcs']").val();
					var item85Qcs=$("input[name='item85Qcs']").val();
					var a=new Array(item73Qcs,item85Qcs);
					var sum=0;
					for(var i=0;i<a.length;i++){
						if(a[i]!=null&&a[i]!=""){
							var b=parseFloat(a[i]);
							sum+=b;
						}
					}
					$("input[name='item86Qcs']").val(sum);
				});
		
		$("input[name='item86Qms']").focus(
				function() {
					var item73Qms=$("input[name='item73Qms']").val();
					var item85Qms=$("input[name='item85Qms']").val();
					var a=new Array(item73Qms,item85Qms);
					var sum=0;
					for(var i=0;i<a.length;i++){
						if(a[i]!=null&&a[i]!=""){
							var b=parseFloat(a[i]);
							sum+=b;
						}
					}
					$("input[name='item86Qms']").val(sum);
				});
		
		
		
	})
</script>
</head>
<body>
	<table width="80%" border="1" cellspacing="0" align="center">
		<caption align="top" style="font-size: 30px;">资产负债表</caption>
		<tr>
			<th align="center">资产</th>
			<th align="center">项目</th>
			<th align="center">期初数</th>
			<th align="center">期末数</th>
			<th align="center">负债及所有者权益</th>
			<th align="center">项目</th>
			<th align="center">期初数</th>
			<th align="center">期末数</th>
		</tr>
		<tr>
			<td>流动资产：</td>
			<td name="xm">1</td>
			<td width="20"><input type="text" name="item1Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item1Qms"
				style="border: none; height: 100%" /></td>
			<td>流动负债：</td>
			<td>44</td>
			<td width="20"><input type="text" name="item44Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item44Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>货币资金</td>
			<td name="xm">2</td>
			<td width="20"><input type="text" name="item2Qcs"
				style="border: none; height: 100%"  /></td>
			<td width="20"><input type="text" name="item2Qms"
				style="border: none; height: 100%" /></td>
			<td>短期借款</td>
			<td>45</td>
			<td width="20"><input type="text" name="item45Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item45Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>以公允价值计量且其变动计入当期损益的金融资产</td>
			<td name="xm">3</td>
			<td width="20"><input type="text" name="item3Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item3Qms"
				style="border: none; height: 100%" /></td>
			<td>以公允价值计量且其变动计入当期损益的金融负债</td>
			<td>46</td>
			<td width="20"><input type="text" name="item46Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item46Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>衍生金融资产</td>
			<td name="xm">4</td>
			<td width="20"><input type="text" name="item4Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item4Qms"
				style="border: none; height: 100%" /></td>
			<td>衍生金融负债</td>
			<td>47</td>
			<td width="20"><input type="text" name="item47Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item47Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>应收票据</td>
			<td name="xm">5</td>
			<td width="20"><input type="text" name="item5Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item5Qms"
				style="border: none; height: 100%" /></td>
			<td>应付票据</td>
			<td>48</td>
			<td width="20"><input type="text" name="item48Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item48Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>应收账款</td>
			<td name="xm">6</td>
			<td width="20"><input type="text" name="item6Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item6Qms"
				style="border: none; height: 100%" /></td>
			<td>应付账款</td>
			<td>49</td>
			<td width="20"><input type="text" name="item49Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item49Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>预付款项</td>
			<td name="xm">7</td>
			<td width="20"><input type="text" name="item7Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item7Qms"
				style="border: none; height: 100%" /></td>
			<td>预收款项</td>
			<td>50</td>
			<td width="20"><input type="text" name="item50Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item50Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>应收利息</td>
			<td name="xm">8</td>
			<td width="20"><input type="text" name="item8Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item8Qms"
				style="border: none; height: 100%" /></td>
			<td>应付职工薪酬</td>
			<td>51</td>
			<td width="20"><input type="text" name="item51Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item51Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>应收股利</td>
			<td name="xm">9</td>
			<td width="20"><input type="text" name="item9Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item9Qms"
				style="border: none; height: 100%" /></td>
			<td>应交税费</td>
			<td>52</td>
			<td width="20"><input type="text" name="item52Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item52Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>其他应收款</td>
			<td name="xm">10</td>
			<td width="20"><input type="text" name="item10Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item10Qms"
				style="border: none; height: 100%" /></td>
			<td>应付利息</td>
			<td>53</td>
			<td width="20"><input type="text" name="item53Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item53Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>存货</td>
			<td name="xm">11</td>
			<td width="20"><input type="text" name="item11Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item11Qms"
				style="border: none; height: 100%" /></td>
			<td>应付股利</td>
			<td>54</td>
			<td width="20"><input type="text" name="item54Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item54Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>划分为持有待售的资产</td>
			<td name="xm">12</td>
			<td width="20"><input type="text" name="item12Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item12Qms"
				style="border: none; height: 100%" /></td>
			<td>其他应付款</td>
			<td>55</td>
			<td width="20"><input type="text" name="item55Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item55Qms"
				style="border: none; height: 100%" /></td>
		</tr>




		<tr>
			<td>一年内到期的非流动资产</td>
			<td name="xm">13</td>
			<td width="20"><input type="text" name="item13Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item13Qms"
				style="border: none; height: 100%" /></td>
			<td>划分为持有待售的负债</td>
			<td>56</td>
			<td width="20"><input type="text" name="item56Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item56Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>其他流动资产</td>
			<td name="xm">14</td>
			<td width="20"><input type="text" name="item14Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item14Qms"
				style="border: none; height: 100%" /></td>
			<td>一年内到期的非流动负债</td>
			<td>57</td>
			<td width="20"><input type="text" name="item57Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item57Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>流动资产合计</td>
			<td name="xm">15</td>
			<td width="20"><input type="text" name="item15Qcs"
				style="border: none; background-color: cyan;"
				readonly="readonly" /></td>
			<td width="20"><input type="text" name="item15Qms"
				style="border: none; background-color: cyan;"
				readonly="readonly" /></td>
			<td>其他流动负债</td>
			<td>58</td>
			<td width="20"><input type="text" name="item58Qcs"
				style="border: none; height: 100%"
				/></td>
			<td width="20"><input type="text" name="item58Qms"
				style="border: none;  height: 100%"
				/></td>
		</tr>
		<tr>
			<td>非流动资产：</td>
			<td name="xm">16</td>
			<td width="20"><input type="text" name="item16Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item16Qms"
				style="border: none; height: 100%" /></td>
			<td>流动负债合计</td>
			<td>59</td>
			<td width="20"><input type="text" name="item59Qcs"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
			<td width="20"><input type="text" name="item59Qms"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>可供出售金融资产</td>
			<td name="xm">17</td>
			<td width="20"><input type="text" name="item17Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item17Qms"
				style="border: none; height: 100%" /></td>
			<td>非流动负债：</td>
			<td>60</td>
			<td width="20"><input type="text" name="item60Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item60Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>持有至到期投资</td>
			<td name="xm">18</td>
			<td width="20"><input type="text" name="item18Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item18Qms"
				style="border: none; height: 100%" /></td>
			<td>长期借款</td>
			<td>61</td>
			<td width="20"><input type="text" name="item61Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item61Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>长期应收款</td>
			<td name="xm">19</td>
			<td width="20"><input type="text" name="item19Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item19Qms"
				style="border: none; height: 100%" /></td>
			<td>应付债券</td>
			<td>62</td>
			<td width="20"><input type="text" name="item62Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item62Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>长期股权投资</td>
			<td name="xm">20</td>
			<td width="20"><input type="text" name="item20Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item20Qms"
				style="border: none; height: 100%" /></td>
			<td>其中：优先股</td>
			<td>63</td>
			<td width="20"><input type="text" name="item63Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item63Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>投资性房地产</td>
			<td name="xm">21</td>
			<td width="20"><input type="text" name="item21Qcs"
				style="border: none; height: 100%;" /></td>
			<td width="20"><input type="text" name="item21Qms"
				style="border: none; height: 100%" /></td>
			<td>永续债</td>
			<td>64</td>
			<td width="20"><input type="text" name="item64Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item64Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>固定资产</td>
			<td name="xm">22</td>
			<td width="20"><input type="text" name="item22Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item22Qms"
				style="border: none; height: 100%" /></td>
			<td>长期应付款</td>
			<td>65</td>
			<td width="20"><input type="text" name="item65Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item65Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>在建工程</td>
			<td name="xm">23</td>
			<td width="20"><input type="text" name="item23Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item23Qms"
				style="border: none; height: 100%" /></td>
			<td>长期应付职工薪酬</td>
			<td>66</td>
			<td width="20"><input type="text" name="item66Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item66Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>工程物资</td>
			<td name="xm">24</td>
			<td width="20"><input type="text" name="item24Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item24Qms"
				style="border: none; height: 100%" /></td>
			<td>专项应付款</td>
			<td>67</td>
			<td width="20"><input type="text" name="item67Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item67Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>固定资产清理</td>
			<td name="xm">25</td>
			<td width="20"><input type="text" name="item25Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item25Qms"
				style="border: none; height: 100%" /></td>
			<td>预计负债</td>
			<td>68</td>
			<td width="20"><input type="text" name="item68Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item68Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>生产性生物资产</td>
			<td name="xm">26</td>
			<td width="20"><input type="text" name="item26Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item26Qms"
				style="border: none; height: 100%" /></td>
			<td>递延收益</td>
			<td>69</td>
			<td width="20"><input type="text" name="item69Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item69Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>油气资产</td>
			<td name="xm">27</td>
			<td width="20"><input type="text" name="item27Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item27Qms"
				style="border: none; height: 100%" /></td>
			<td>递延所得税负债</td>
			<td>70</td>
			<td width="20"><input type="text" name="item70Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item70Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>无形资产</td>
			<td name="xm">28</td>
			<td width="20"><input type="text" name="item28Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item28Qms"
				style="border: none; height: 100%" /></td>
			<td>其他非流动负债</td>
			<td>71</td>
			<td width="20"><input type="text" name="item71Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item71Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>开发支出</td>
			<td name="xm">29</td>
			<td width="20"><input type="text" name="item29Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item29Qms"
				style="border: none; height: 100%" /></td>
			<td>非流动负债合计</td>
			<td>72</td>
			<td width="20"><input type="text" name="item72Qcs"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
			<td width="20"><input type="text" name="item72Qms"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>商誉</td>
			<td name="xm">30</td>
			<td width="20"><input type="text" name="item30Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item30Qms"
				style="border: none; height: 100%" /></td>
			<td>负债合计</td>
			<td>73</td>
			<td width="20"><input type="text" name="item73Qcs"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
			<td width="20"><input type="text" name="item73Qms"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>长期待摊费用</td>
			<td name="xm">31</td>
			<td width="20"><input type="text" name="item31Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item31Qms"
				style="border: none; height: 100%" /></td>
			<td>所有者权益(或股东权益)：</td>
			<td>74</td>
			<td width="20"><input type="text" name="item74Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item74Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>递延所得税资产</td>
			<td name="xm">32</td>
			<td width="20"><input type="text" name="item32Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item32Qms"
				style="border: none; height: 100%" /></td>
			<td>实收资本(或股本)</td>
			<td>75</td>
			<td width="20"><input type="text" name="item75Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item75Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>其他非流动资产</td>
			<td name="xm">33</td>
			<td width="20"><input type="text" name="item33Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item33Qms"
				style="border: none; height: 100%" /></td>
			<td>其他权益工具</td>
			<td>76</td>
			<td width="20"><input type="text" name="item76Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item76Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td>非流动资产合计</td>
			<td name="xm">34</td>
			<td width="20"><input type="text" name="item34Qcs"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
			<td width="20"><input type="text" name="item34Qms"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
			<td>其中：优先股</td>
			<td>77</td>
			<td width="20"><input type="text" name="item77Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item77Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td />
			<td name="xm">35</td>
			<td width="20"><input type="text" name="item35Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item35Qms"
				style="border: none; height: 100%" /></td>
			<td>永续债</td>
			<td>78</td>
			<td width="20"><input type="text" name="item78Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item78Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td />
			<td name="xm">36</td>
			<td width="20"><input type="text" name="item36Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item36Qms"
				style="border: none; height: 100%" /></td>
			<td>资本公积</td>
			<td>79</td>
			<td width="20"><input type="text" name="item79Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item79Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td />
			<td name="xm">37</td>
			<td width="20"><input type="text" name="item37Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item37Qms"
				style="border: none; height: 100%" /></td>
			<td>减：库存股</td>
			<td>80</td>
			<td width="20"><input type="text" name="item80Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item80Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td></td>
			<td name="xm">38</td>
			<td width="20"><input type="text" name="item38Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item38Qms"
				style="border: none; height: 100%" /></td>
			<td>其他综合收益</td>
			<td>81</td>
			<td width="20"><input type="text" name="item81Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item81Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td></td>
			<td name="xm">39</td>
			<td width="20"><input type="text" name="item39Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item39Qms"
				style="border: none; height: 100%" /></td>
			<td>专项储备</td>
			<td>82</td>
			<td width="20"><input type="text" name="item82Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item82Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td></td>
			<td name="xm">40</td>
			<td width="20"><input type="text" name="item40Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item40Qms"
				style="border: none; height: 100%" /></td>
			<td>盈余公积</td>
			<td>83</td>
			<td width="20"><input type="text" name="item83Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item83Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td></td>
			<td name="xm">41</td>
			<td width="20"><input type="text" name="item41Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item41Qms"
				style="border: none; height: 100%" /></td>
			<td>未分配利润</td>
			<td>84</td>
			<td width="20"><input type="text" name="item84Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item84Qms"
				style="border: none; height: 100%" /></td>
		</tr>
		<tr>
			<td></td>
			<td name="xm">42</td>
			<td width="20"><input type="text" name="item42Qcs"
				style="border: none; height: 100%" /></td>
			<td width="20"><input type="text" name="item42Qms"
				style="border: none; height: 100%" /></td>
			<td>所有者权益(或股东权益)合计</td>
			<td>85</td>
			<td width="20"><input type="text" name="item85Qcs"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
			<td width="20"><input type="text" name="item85Qms"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
		</tr>
		<tr>
			<td>资产总计</td>
			<td name="xm">43</td>
			<td ><input type="text" name="item43Qcs"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
			<td width="20"><input type="text" name="item43Qms"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
			<td>负债和所有者权益(或股东权益)总计</td>
			<td>86</td>
			<td width="20"><input type="text" name="item86Qcs"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
			<td width="20"><input type="text" name="item86Qms"
				style="border: none; background-color: cyan; height: 100%"
				readonly="readonly" /></td>
		</tr>

	</table>
</body>
</html>