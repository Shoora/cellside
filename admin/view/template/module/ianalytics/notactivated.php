<?php $iModuleNotActivated = empty($data['iAnalytics']['Enabled']); ?>
<?php if ($iModuleNotActivated==true){ ?>
<style> .iModuleContent .box .content { display:none } </style>
<script> $('.submitButton').html('Activate'); </script>
<div class="notActivatedContent">
	<h1>iAnalytics is not activated.</h1>
	<a href="javascript:void(0)" onclick="$('#form').attr('action',$('#form').attr('action')+'&activate=true'); $('#form').submit();" class="iModuleActivateButton">Activate iAnalytics</a>
</div>
<?php } ?>