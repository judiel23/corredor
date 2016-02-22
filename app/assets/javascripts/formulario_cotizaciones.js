/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(function(){
   
    $("#form_uni_seguro_anoveh").change(function(){
        var selected = $(this).val();
        $.ajax({
            type: "GET",
            data: { anio: selected },
            url: "/form_uni_seguros/get_marcas_by_anio",
            success: function(response){
              $("#form_uni_seguro_codmarca").html(function(){
                var options_str = "<option value=''>Seleccione...</option>";

                $.map(response, function(v){
                  options_str += "<option value='" + v.codmarca +"'>" + v.descmarca + "</option>";
                }).join('');
                return options_str;
              });
            }
        });
    });
    
    $("#form_uni_seguro_codmarca").change(function(){
        var anio_veh = $("#form_uni_seguro_anoveh").val();
        var selected = $(this).val();
        $.ajax({
            type: "GET",
            data: { anio: anio_veh, marca: selected },
            url: "/form_uni_seguros/get_modelo_vehicle",
            success: function(response){
              $("#form_uni_seguro_codmodelo").html(function(){
                var options_str = "<option value=''>Seleccione...</option>";

                $.map(response, function(v){
                  options_str += "<option value='" + v.codmodelo +"'>" + v.descmodelo + "</option>";
                }).join('');
                return options_str;
              });
            }
        });
    });
    
    $("#form_uni_seguro_codmodelo").change(function(){
        var anio_veh = $("#form_uni_seguro_anoveh").val();
        var mark_veh = $("#form_uni_seguro_codmarca").val();
        var selected = $(this).val();
        $.ajax({
            type: "GET",
            data: { anio: anio_veh, marca: mark_veh, modelo: selected },
            url: "/form_uni_seguros/get_version_automv",
            success: function(response){
              $("#form_uni_seguro_codversion").html(function(){
                var options_str = "<option value=''>Seleccione...</option>";

                $.map(response, function(v){
                  options_str += "<option value='" + v.codversion +"'>" + v.descversion + "</option>";
                }).join('');
                return options_str;
              });
            }
        });
    });
});