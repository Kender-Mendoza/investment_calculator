class Calculate {
  constructor() {
    this.form = $("#calculate-form")
    this.input = $("#amount")
    this.bodyTable = $("#table-body")
    this.printButton = $("#pnt-csv-button")

    this.onCalculate();
    //this.printProjection();
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
}

new Calculate()