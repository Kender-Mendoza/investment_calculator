class Calculate {
  constructor() {
    this.form = $("#calculate-form")
    this.input = $("#amount")
    this.bodyTable = $("#table-body")
    this.printButton = $("#print-csv-button")

    this.onCalculate();
    this.printProjection();
  }

  onCalculate() {
    this.form.on("submit", (event) => {
      event.preventDefault();

      $.ajax({
        url: this.form.attr("action"),
        method: this.form.attr("method"),
        dataType: "json",
        data: {
          authenticity_token: $('meta[name=csrf-token]').attr('content'),
          amount: this.input.val()
        },
        success: $.proxy((data) => {
          this.printButton.data("projection", data.data)
          this.bodyTable.html("")
          $.each(data.data, (key, value) => {
            this.bodyTable.append(
              `
                <tr>
                  <td> ${ value.month_number } </td>
                  <td> ${ value.btc_amount } </td>
                  <td> ${ value.eth_amount } </td>
                </tr>
              `
            )
          })
        }, this),
        error: $.proxy(() => {
          alert("An error occurred, try again later")
        }, this)
      });
    })
  }

  printProjection() {
    this.printButton.on("click", (event) => {
      event.preventDefault();

      $.ajax({
        url: "/print_projection",
        method: "POST",
        xhrFields: {
          responseType: "blob"
        },
        data: {
          authenticity_token: $('meta[name=csrf-token]').attr('content'),
          btc_data: $("#print-csv-button").data("btc-data"),
          eth_data: $("#print-csv-button").data("eth-data"),
          projection: $("#print-csv-button").data("projection")
        },
        success: $.proxy((data) => {
          const blob = new Blob([data], {type: "text/csv"}),
                url = URL.createObjectURL(blob);

          window.open(url);
        }, this)
      });
    })
  }
}

new Calculate()
