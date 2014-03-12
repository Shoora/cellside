<?php echo $plain_header; ?>
<div class="qap-container" style="padding:20px;">
	<table class="table table-striped table-condensed qap-bbcode-list">
		<thead>
		<tr>
			<th style="width:20%;"><?php echo $text_name; ?></th>
			<th style="width:15%;"><?php echo $text_tag; ?></th>
			<th><?php echo $text_syntax; ?></th>
		</tr>
		</thead>
		<tbody style="line-height:150%;">
		<?php foreach ($tags as $tag) {
			switch ($tag) {
				case 'b': ?>
		<tr>
			<td><strong>Bold</strong></td>
			<td>b</td>
			<td>[b]{text}[/b]</td>
		</tr>
		<?php break;
			  case 'i': ?>
		<tr>
			<td><strong>Italic</strong></td>
			<td>i</td>
			<td>[i]{text}[/i]</td>
		</tr>
		<?php break;
			  case 'u': ?>
		<tr>
			<td><strong>Underline</strong></td>
			<td>u</td>
			<td>[u]{text}[/u]</td>
		</tr>
		<?php break;
			  case 's': ?>
		<tr>
			<td><strong>Striketrough</strong></td>
			<td>s</td>
			<td>[s]{text}[/s]</td>
		</tr>
		<?php break;
			  case 'quote': ?>
		<tr>
			<td><strong>Quote</strong></td>
			<td>quote</td>
			<td>
				<span class="text-muted">Plain:</span> [quote]{text}[/quote]<br/>
				<span class="text-muted">Cited:</span> [quote={author}]{text}[/quote]
			</td>
		</tr>
		<?php break;
			  case 'code': ?>
		<tr>
			<td><strong>Code</strong></td>
			<td>code</td>
			<td>[code]{text}[/code]</td>
		</tr>
		<?php break;
			  case 'list': ?>
		<tr>
			<td><strong>List</strong></td>
			<td>list</td>
			<td>
				<span class="text-muted">Unordered list:</span> [list]{items}[/list]<br/>
				<span class="text-muted">Ordered list:</span> [list={option}]{items}[/list]<br/>
				<span class="text-muted">List item:</span> [li]{text}[/li]<br/>
				<span class="text-muted">List item:</span> [*]{text}\newline<br/>
			</td>
		</tr>
		<?php break;
			  case 'img': ?>
		<tr>
			<td><strong>Image</strong></td>
			<td>img</td>
			<td>[img]{url}[/img]</td>
		</tr>
		<?php break;
			  case 'url': ?>
		<tr>
			<td><strong>Link</strong></td>
			<td>url</td>
			<td>
				<span class="text-muted">Plain:</span> [url]{url}[/url]<br/>
				<span class="text-muted">Named:</span> [url={url}]{text}[/url]
			</td>
		</tr>
		<?php break;
			  case 'size': ?>
		<tr>
			<td><strong>Font size</strong></td>
			<td>size</td>
			<td>[size={number}]{text}[/size]</td>
		</tr>
		<?php break;
			  case 'color': ?>
		<tr>
			<td><strong>Font colour</strong></td>
			<td>color</td>
			<td>[color={color}]{text}[/color]</td>
		</tr>
		<?php break;
			}
		} ?>
		</tbody>
	</table>
</div>
<?php echo $plain_footer; ?>