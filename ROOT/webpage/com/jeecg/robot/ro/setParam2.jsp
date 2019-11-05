<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
<div class="bt-item col-md-6 col-sm-6">
	<div class="row">
		<div class="bt-label">
			|直播摄像头配置
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			IP：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="liveCamerasIp" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.liveCamerasIp}"  ignore="ignore"  />
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			端口：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="liveCamerasPort" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.liveCamerasPort}"  ignore="ignore"  />
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			用户名：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="liveCamerasName" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.liveCamerasName}"  ignore="ignore"  />
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			密码：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="liveCamerasPwd" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.liveCamerasPwd}"  ignore="ignore"  />
		</div>
	</div>
	
	<div class="row">
		<div class="bt-label">
			|滑竿直播摄像头配置
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			IP：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="silderCamerasIp" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.silderCamerasIp}"  ignore="ignore"  />
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			端口：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="silderCamerasPort" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.silderCamerasPort}"  ignore="ignore"  />
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			用户名：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="silderCamerasName" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.silderCamerasName}"  ignore="ignore"  />
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			密码：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="silderCamerasPwd" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.silderCamerasPwd}"  ignore="ignore"  />
		</div>
	</div>
	
	<div class="row">
		<div class="bt-label">
			|热成像仪配置
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			IP：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="imgCamerasIp" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasIp}"  ignore="ignore"  />
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			端口：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="imgCamerasPort" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasPort}"  ignore="ignore"  />
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			用户名：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="imgCamerasName" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasName}"  ignore="ignore"  />
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			密码：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="imgCamerasPwd" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.imgCamerasPwd}"  ignore="ignore"  />
		</div>
	</div>
	
	<div class="row">
		<div class="bt-label">
			|服务器配置
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			IP：
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			<input name="serverIp" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.serverIp}"  ignore="ignore"  />
		</div>
	</div>
</div>