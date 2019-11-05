<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="bootstrap,layer,validform,bootstrap-form"></t:base>
<div class="bt-item col-md-12 col-sm-12" style="display: none;" id="temperatureId">
	<div class="row">
		<div class="col-md-2 col-sm-2 col-xs-2 bt-label">
			<input name="temperatureFlag" class="rt2" id="temperatureFlag" type="hidden" value = "${tbRoRobotsParam.temperatureFlag}" onchange = "temperatureFlagChange()"/>
			温度设置：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="temperatureLow" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.temperatureLow}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			~
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="temperatureHigh" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.temperatureHigh}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			℃
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			注：推荐标准为23+/-1℃
		</div>
	</div>
</div>
<div class="bt-item col-md-12 col-sm-12" style="display: none;" id="humidityId">
	<div class="row">
		<div class="col-md-2 col-sm-2 col-xs-2 bt-label">
			<input name="humidityFlag" class="rt2" id="humidityFlag" type="hidden" value = "${tbRoRobotsParam.humidityFlag}" onchange = "humidityFlagChange()"/>
			湿度设置：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="humidityLow" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.humidityLow}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			~
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="humidityHigh" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.humidityHigh}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			%
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			注：推荐标准为40%~50%
		</div>
	</div>
</div>
<div class="bt-item col-md-12 col-sm-12" style="display: none;" id="noiseId">
	<div class="row">
		<div class="col-md-2 col-sm-2 col-xs-2 bt-label">
			<input name="noiseFlag" class="rt2" id="noiseFlag" type="hidden"  value = "${tbRoRobotsParam.noiseFlag}" onchange = "noiseFlagChange()"/>
			噪声设置：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="noiseLow" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.noiseLow}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			~
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="noiseHigh" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.noiseHigh}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			dB
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			注：推荐标准为65dB~80dB
		</div>
	</div>
</div>
<div class="bt-item col-md-12 col-sm-12" style="display: none;" id="pm25Id">
	<div class="row">
		<div class="col-md-2 col-sm-2 col-xs-2 bt-label">
			<input name="pm25Flag" class="rt2" id="pm25Flag" type="hidden" value = "${tbRoRobotsParam.pm25Flag}" onchange = "pm25FlagChange()"/>
			PM2.5设置：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="pm25Low" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.pm25Low}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			~
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="pm25High" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.pm25High}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			μg/m3
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			注：推荐标准为0μg/m3~35μg/m3
		</div>
	</div>
</div>
<div class="bt-item col-md-12 col-sm-12" style="display: none;" id="pollutionGasId">
	<div class="row">
		<div class="col-md-2 col-sm-2 col-xs-2 bt-label">
			<input name="pollutionGasFlag" class="rt2" id="pollutionGasFlag" type="hidden" value = "${tbRoRobotsParam.pollutionGasFlag}" onchange = "pollutionGasFlagChange()"/>
			污染气体：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="pollutionGasLow" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.pollutionGasLow}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			~
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="pollutionGasHigh" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.pollutionGasHigh}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			PPM
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			注：每立方米的大气中含有污染物的体积数
		</div>
	</div>
</div>
<div class="bt-item col-md-12 col-sm-12" id="equipmentTemperatureId">
	<div class="row">
		<div class="col-md-2 col-sm-2 col-xs-2 bt-label">
			<input name="equipmentTemperatureFlag" class="rt2" id="equipmentTemperatureFlag" type="hidden" value = "${tbRoRobotsParam.equipmentTemperatureFlag}" onchange = "equipmentTemperatureFlagChange()"/>
			设备温度：
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="equipmentTemperatureLow" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.equipmentTemperatureLow}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			~
		</div>
		<div class="col-md-2 col-sm-2 col-xs-2 bt-content">
			<input name="equipmentTemperatureHigh" type="text" class="form-control" maxlength="100" value = "${tbRoRobotsParam.equipmentTemperatureHigh}"  ignore="ignore"  />
		</div>
		<div class="col-md-1 col-sm-1 col-xs-1 bt-content">
			℃
		</div>
		<div class="col-md-4 col-sm-4 col-xs-4 bt-content">
			注：推荐标准为23+/-1℃
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	//此处选择与机器人列表-参数设置-动环阈值设置中一致
	var sensors = '${tbRoRobotsParam.sensors}';
	if(sensors && sensors.split(",").length > 0) {
		var arrSen = sensors.split(",");
		for(var i = 0; i < arrSen.length; i++) {
			if(arrSen[i] == '01') { //温湿度传感器
				$("#temperatureId").show();
				$("#humidityId").show();
			}
			if(arrSen[i] == '02') { //噪音传感器
				$("#noiseId").show();
			}
			if(arrSen[i] == '03') { //PM2.5传感器
				$("#pm25Id").show();
			}
			if(arrSen[i] == '04') { //污染气体传感器
				$("#pollutionGasId").show();
			}
		}
	}
	
	//回显选中项
	var temperatureFlag = '${tbRoRobotsParam.temperatureFlag}';
	var humidityFlag = '${tbRoRobotsParam.humidityFlag}';
	var noiseFlag = '${tbRoRobotsParam.noiseFlag}';
	var pm25Flag = '${tbRoRobotsParam.pm25Flag}';
	var pollutionGasFlag = '${tbRoRobotsParam.pollutionGasFlag}';
	var equipmentTemperatureFlag = '${tbRoRobotsParam.equipmentTemperatureFlag}';
	if(temperatureFlag && temperatureFlag == 1) {
		$('#temperatureFlag').attr("checked", true);
	}
	if(humidityFlag && humidityFlag == 1) {
		$('#humidityFlag').attr("checked", true);
	}
	if(noiseFlag && noiseFlag == 1) {
		$('#noiseFlag').attr("checked", true);
	}
	if(pm25Flag && pm25Flag == 1) {
		$('#pm25Flag').attr("checked", true);
	}
	if(pollutionGasFlag && pollutionGasFlag == 1) {
		$('#pollutionGasFlag').attr("checked", true);
	}
	if(equipmentTemperatureFlag && equipmentTemperatureFlag == 1) {
		$('#equipmentTemperatureFlag').attr("checked", true);
	}
});

//改变事件
function temperatureFlagChange () {
	var temperatureFlag = $('#temperatureFlag').is(':checked');
	if(temperatureFlag) {
		$('#temperatureFlag').val(1);
	} else {
		$('#temperatureFlag').val(0);
	}
}
//改变事件
function humidityFlagChange () {
	var humidityFlag = $('#humidityFlag').is(':checked');
	if(humidityFlag) {
		$('#humidityFlag').val(1);
	} else {
		$('#humidityFlag').val(0);
	}
}
//改变事件
function noiseFlagChange () {
	var noiseFlag = $('#noiseFlag').is(':checked');
	if(noiseFlag) {
		$('#noiseFlag').val(1);
	} else {
		$('#noiseFlag').val(0);
	}
}
//改变事件
function pm25FlagChange () {
	var pm25Flag = $('#pm25Flag').is(':checked');
	if(pm25Flag) {
		$('#pm25Flag').val(1);
	} else {
		$('#pm25Flag').val(0);
	}
}
//改变事件
function pollutionGasFlagChange () {
	var pollutionGasFlag = $('#pollutionGasFlag').is(':checked');
	if(pollutionGasFlag) {
		$('#pollutionGasFlag').val(1);
	} else {
		$('#pollutionGasFlag').val(0);
	}
}
//改变事件
function equipmentTemperatureFlagChange () {
	var equipmentTemperatureFlag = $('#equipmentTemperatureFlag').is(':checked');
	if(equipmentTemperatureFlag) {
		$('#equipmentTemperatureFlag').val(1);
	} else {
		$('#equipmentTemperatureFlag').val(0);
	}
}

</script>