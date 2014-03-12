<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><?php echo $title; ?></title>
</head>
<body style="margin:0;padding:0;background:#ddd;">
<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" style="background:#ddd">
	<tbody>
		<tr>
			<td style="padding:24px 0;">
				<table align="center" cellpadding="0" cellspacing="0" border="0" width="670" style="background:#fff;border:0;border-left:1px solid #ccc;border-right:1px solid #ccc">
					<tbody>
						<tr>
							<td>
								<table cellpadding="0" cellspacing="0" border="0" width="670" style="background:#f2f2f2;table-layout:fixed;">
									<tbody>
										<tr>
											<td height="25" style="border-top:1px solid #ccc;"></td>
										</tr>
										<tr>
											<td valign="middle" style="padding-left:70px;">
												<a href="<?php echo $store_url; ?>" title="<?php echo $store_name; ?>"><img src="<?php echo $logo; ?>" style="border:0;line-height:100%;border:0" alt="<?php echo $store_name; ?>"></a>
											</td>
										</tr>
										<tr>
											<td height="16"></td>
										</tr>
										<tr>
											<td style="background:#fff;border-top:1px solid #ddd;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif">&nbsp;</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td style="background:#fff">
								<table bgcolor="#ffffff" width="670" border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td style="width:65px">&nbsp;</td>
											<td valign="top">
												<table width="100%" border="0" cellspacing="0" cellpadding="0">
													<tbody>
														<tr>
															<td width="10">&nbsp;</td>
															<td style="padding:0px;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;color:#333333">
																<p style="margin:0;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;color:#555555;font-size:14px;padding-top:10px;">
																	<?php if ($product) { ?>
																	<?php echo sprintf($text_product_question, $author, '<a href="' . $product_url . '" style="text-decoration:none;color:#0084b4;">' . $product_name . '</a>'); ?>
																	<?php } else { ?>
																	<?php echo sprintf($text_general_question, $author); ?>
																	<?php } ?>
																</p>
																<p style="margin:0;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;color:#555555;font-size:14px;padding-top:10px;"><?php echo $text_answer_question; ?>
																	<br/>
																	<a href="<?php echo $admin_link; ?>" style="text-decoration:none;color:#0084b4;font-size:12px;"><?php echo $admin_link; ?></a>
																</p>
															</td>
															<td width="10">&nbsp;</td>
														</tr>
														<tr>
															<td width="10" height="20" colspan="3">&nbsp;</td>
														</tr>
													</tbody>
												</table>
												<table width="100%" border="0" cellspacing="0" cellpadding="10">
													<tbody>
														<tr>
															<td style="border-top:2px solid #e8e8e8;padding:10px;">
																<h1 style="font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;color:#333333;font-size:16px;margin-top:0px;margin-bottom:0px"><?php echo $text_question_details; ?></h1>
															</td>
														</tr>
													</tbody>
												</table>
												<table style="border-top:solid 1px #e8e8e8;border-bottom:solid 1px #e8e8e8;margin-bottom:20px;" width="100%" border="0" cellspacing="0" cellpadding="10">
													<tbody>
														<tr>
															<td>
																<table width="100%" border="0" cellspacing="0" cellpadding="0">
																	<tbody>
																		<tr>
																			<td valign="top" style="width:60px;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;color:#666;font-size:24px;text-align:center;font-weight:bold;"> <?php echo $text_question_short; ?> </td>
																			<td valign="top">
																				<div>
																					<span style="font-family:Georgia,'Times New Roman',Times,serif;color:#666;font-size:13px;margin-top:0px;margin-bottom:0px;line-height:1em"><?php echo $question; ?></span>
																				</div>
																				<?php if ($question_details) { ?>
																				<div style="padding-top:10px;">
																					<span style="font-family:Georgia,'Times New Roman',Times,serif;color:#666;font-size:13px;margin-top:0px;margin-bottom:0px;line-height:1em"><?php echo $question_details; ?></span>
																				</div>
																				<?php } ?>
																				<div style="margin-top:10px;margin-left:15px;margin-bottom:0px;">
																					<span style="font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;color:#333333;font-size:14px;font-weight:bold;line-height:1em;"><?php echo $question_author; ?></span>
																					<span style="font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;color:#999999;font-size:13px;font-style:italic;line-height:1em;margin-left:5px;">[ <?php if ($question_author_email) { ?><a href="mailto:<?php echo $question_author_email; ?>" style="text-decoration:none;color:#0084b4;"><?php echo $question_author_email; ?></a>, <?php } ?><?php echo $question_date; ?>, <?php echo $text_ip; ?> <a href="http://www.geoiptool.com/en/?IP=<?php echo $ip_address; ?>" style="text-decoration:none;color:#0084b4;"><?php echo $ip_address; ?></a> ]</span>
																				</div>
																			</td>
																		</tr>
																	</tbody>
																</table>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td style="width:65px">&nbsp;</td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td>
							<table bgcolor="#eeeeee" border="0" cellpadding="0" cellspacing="0" width="670" style="background-color:#eee;border-top-color:#ddd;border-top-style:solid;border-top-width:1px">
								<tbody>
									<tr>
										<td colspan="4" height="16"></td>
									</tr>
									<tr>
										<td style="width:85px"></td>
										<td style="font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;font-size:12px;line-height:17px;color:#777;text-align:center;">
												<a href="<?php echo $store_url; ?>" style="border:none;color:#0084b4;text-decoration:none;font-weight:bold;" target="_blank"><?php echo $store_name; ?></a> <?php echo $text_powered_by; ?> <a href="http://www.opencart.com" style="border:none;color:#0084b4;text-decoration:none;" target="_blank">OpenCart</a>
											</td>
											<td style="width:85px"></td>
										</tr>
										<tr>
											<td colspan="3" height="25" style="border-bottom:1px solid #ccc;"></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</tbody>
</table>
</body>
</html>