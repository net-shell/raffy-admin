<?php $code = json_encode($dataTypeContent->{$row->field}); ?>

<div id="{{ $row->field }}" data-theme="{{ @$options->theme }}" data-language="{{ @$options->language }}"
     class="ace_editor min_height_200"
     name="{{ $row->field }}">{{ old($row->field, $code ?? $options->default ?? '') }}</div>

<textarea name="{{ $row->field }}" id="{{ $row->field }}_textarea"
          class="hidden">{{ old($row->field, $code ?? $options->default ?? '') }}</textarea>
