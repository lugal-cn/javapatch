<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<div>
	<t:tabs id="tabsOne" iframe="false"  tabPosition="top" fit="false">
		<c:if test="${fn:length(lstMap)  > 0 }">
			<c:forEach items="${lstMap}" var="map" varStatus="status">
				<t:tab href="tbAlAlarmSettingsController.do?goOneAlarm&alarmLevel=${map.typecode}" title="${map.typename}" id="tab${status.index}"></t:tab>
			</c:forEach>
		</c:if>
		<%-- <t:tab href="tbAlAlarmSettingsController.do?goOneAlarm&alarmLevel=01" title="一级告警" id="tab1"></t:tab>
		<t:tab href="tbAlAlarmSettingsController.do?goOneAlarm&alarmLevel=02" title="二级告警" id="tab2"></t:tab>
		<t:tab href="tbAlAlarmSettingsController.do?goOneAlarm&alarmLevel=03" title="三级告警" id="tab3"></t:tab>
		<t:tab href="tbAlAlarmSettingsController.do?goOneAlarm&alarmLevel=04" title="四级告警" id="tab4"></t:tab>
		<t:tab href="tbAlAlarmSettingsController.do?goOneAlarm&alarmLevel=05" title="五级告警" id="tab5"></t:tab> --%>
		<t:tab href="tbAlAlarmSettingsController.do?goOneAlarm&alarmLevel=07" title="动环告警" id="tab7"></t:tab>
		<t:tab href="tbAlAlarmSettingsController.do?goOneAlarm&alarmLevel=06" title="机器人告警" id="tab6"></t:tab>
	</t:tabs>
</div>