'use strict';

function notify(message, type) {
    $.growl({
        message: message
    }, {
        type: type,
        z_index: 7777,
        allow_dismiss: false,
        label: 'Cancel',
        className: 'btn-xs btn-inverse',
        placement: {
            from: 'top',
            align: 'right'
        },
        delay: 6000,
        animate: {
            enter: 'animated fadeInRight',
            exit: 'animated flipOutX'
        },
        offset: {
            x: 30,
            y: 30
        }
    });
};

jQuery(function($){
  $.fn.datepicker.dates['pt-BR'] = {
    today: 'Hoje',
    months: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho',
    'Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
    monthsShort: ['Jan','Fev','Mar','Abr','Mai','Jun',
    'Jul','Ago','Set','Out','Nov','Dez'],
    days: ['Domingo','Segunda-feira','Terça-feira','Quarta-feira','Quinta-feira','Sexta-feira','Sábado'],
    daysShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sab'],
    daysMin: ['Dom','Seg','Ter','Qua','Qui','Sex','Sab'],
    format: 'dd/mm/yyyy',
    weekStart: 0};
});

$(document).ready(function(){
    $.ajaxSetup({
        headers:
        { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
    });

    $('.s2').select2();

    favloader.init({
      size: 16,
      radius: 6,
      thickness: 2,
      color: '#0F60A8',
      duration: 5000
    });

    $(document).ajaxStart(function(){
      // favloader.start();
      $("#ajax-loader").addClass("is-active");
    });

    $(document).ajaxStop(function(){
      // favloader.stop();
      $("#ajax-loader").removeClass("is-active");
    });

    document.body.addEventListener('ajax:send', function(event) {
      favloader.start();
      $("#ajax-loader").addClass("is-active");
    });

    document.body.addEventListener('ajax:complete', function(event) {
      favloader.stop();
      $("#ajax-loader").removeClass("is-active");
    });

    setTimeout(function() {
      $('.dataTable').DataTable({
        "language": {
          "url": ROOT_PATH + "dataTables.pt-Br.json"
        }
      });
      $('.dataTable td').css('white-space','initial');

      $('.dataTableSemPesquisa').DataTable({
        "searching": false,
        "language": {
          "url": ROOT_PATH + "dataTables.pt-Br.json"
        }
      });
      $('.dataTableSemPesquisa td').css('white-space','initial');
    }, 350);

    $(".telefone").inputmask({
      mask: "(99)99999-9999",
      removeMaskOnSubmit: true
    });

    $(".cpf").inputmask({
      mask: "999.999.999-99",
      removeMaskOnSubmit: true
    });

    $(".cnpj").inputmask({
      mask: "99.999.999/9999-99",
      removeMaskOnSubmit: true
    });

    $(".caepf").inputmask({
      mask: "999.999.999/999-99",
      removeMaskOnSubmit: true
    });

    $(".cep").inputmask({
      mask: "99999-999",
      removeMaskOnSubmit: true
    });

    $(".exercicio").inputmask({
      mask: "9999",
      removeMaskOnSubmit: true
    });

    $('.date_picker').datepicker({
      autoclose: true,
      language: 'pt-BR'
    });
    $('.quantidade').autoNumeric('init', {aSep:'.', aDec:',', vMin: 0});
    $('.moeda').autoNumeric('init', {aSep:'.', aDec:',', vMin: 0});
    $('.percentual').autoNumeric('init', {aSep:'.', aDec:',', vMin: -9999999999, aSign: " %", pSign: "s"});
    $('.multiplica').autoNumeric('init', {aSep:'.', aDec:',', vMin: -9999999999, aSign: "x  ", pSign: "p"});
    $('.resultado').autoNumeric('init', {aSep:'.', aDec:',', vMin: -9999999999, aSign: "=  ", pSign: "p"});
});

$(document).submit(function(){
  $(".autonumeric").autoNumeric('update', {aSep:'', aDec:'.', vMin:'0'});
  $(".moeda").autoNumeric('update', {aSep:'', aDec:'.', vMin:'0'});
  $(".quantidade").autoNumeric('update', {aSep:'', aDec:'.', vMin:'0'});
  $(".percentual").autoNumeric('update', {aSep:'', aDec:'.', vMin:'0', aSign: "", pSign: "s"});
  $(".multiplica").autoNumeric('update', {aSep:'', aDec:'.', vMin:'0', aSign: "", pSign: "p"});
  $(".resultado").autoNumeric('update', {aSep:'', aDec:'.', vMin:'0', aSign: "", pSign: "p"});

  favloader.start();
  $("#ajax-loader").addClass("is-active");

});

function moeda(valor) {
  if (isNaN(parseFloat(valor))) {
    return "R$ 0,00"
  } else {
    return parseFloat(valor).toLocaleString('pt-br',{style: 'currency', currency: 'BRL'})
  }
}

function formata_data(valor) {
  if (isNaN(parseFloat(valor))) {
    return ""
  } else {
    try {
      const formatar_data = moment(valor);
      return formatar_data.format("DD/MM/Y");
    } catch(err) {

    }
  }
}
