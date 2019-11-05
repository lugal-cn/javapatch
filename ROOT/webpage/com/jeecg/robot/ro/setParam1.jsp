<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
<div class="bt-item col-md-6 col-sm-6">
	<div class="row">
		<div class="bt-label">
			|日常巡检开始前电量自检                                                 
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			最低电量：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="powerValueMin" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.powerValueMin}"  ignore="ignore"  />
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			%
		</div>
	</div>
	<div class="row">
	注：不得小于30%，机器人电量高于设定的数值，才会开始日常巡检。  
	</div>
	<br/>
	<div class="row">
		<div class="bt-label">
			|低电量提醒
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			初次提示电量：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="powerValueFirst" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.powerValueFirst}"  ignore="ignore"  />
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			%
		</div>
	</div>
	<div class="row">
	注：不得小于15%，机器人电量低于设定的数值时，会提示用户是否继续使用机器人，用户选择不继续使用后，机器人将自动回桩充电。
	</div>
	<br/>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			强制回充电量：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="forcedRecharge" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.forcedRecharge}"  ignore="ignore"  />
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			%
		</div>
	</div>
	<div class="row">
	注：不得小于10%，机器人电量低于设定的数值时，将在3分钟内强制回桩充电，并提示用户断开机器人与其他物品的连接。
	</div>
	<br/>
	<div class="row">
		<div class="bt-label">
			|遇障
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			遇障等待时间：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="obstaclesWaitingTime" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.obstaclesWaitingTime}"  ignore="ignore"  />
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			min
		</div>
	</div>
	<br/>
	<div class="row">
		<div class="bt-label">
			|非巡检状态下动环检测
		</div>
	</div>
	<div class="row">
		<div class="col-md-3 col-sm-3 col-xs-3 bt-label">
			时间间隔：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="timeInterval" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.timeInterval}"  ignore="ignore"  />
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			min
		</div>
	</div>
</div>