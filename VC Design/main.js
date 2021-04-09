let app = new Vue({
    el: ".wrapper",
    data: {
        searchProducts: "",
        searchCustomers: "",
        searchRents: "",
        searchCustomersModal: "",
        checkOutDetails: {
            returnDate: "",
            discount: 0.00,
            tax: 0.00,
            subtotal: 0.00,
            total: 0.00,
            idCustomer: -1
        },
        rentConfig: {
            tax: 0.18,
            finePerDay: 0.30
        },
        rentConfigArray: [],
        checkoutList: [],
        customerList: [],
        productList: [],
        rentsList: [],
        productAddModel: {
            Name: "",
            Description: "",
            Price: null,
            Category: "",
            Stock: null
        },
        productEditModel: {
            IdProduct: -1,
            Name: "",
            Description: "",
            Price: null,
            Category: "",
            Stock: null
        },
        productToDelete: -1,
        customerToDelete: -1,
        customerAddModel: {
            DNI: "",
            Firstname: "",
            Lastname: "",
            Address: "",
            Gender: "",
            Phone: ""
        },
        customerEditModel: {
            IdCustomer: -1,
            DNI: "",
            Firstname: "",
            Lastname: "",
            Address: "",
            Gender: "",
            Phone: ""
        },
        menuList: [{
                header: "Products",
                icon: "shopping-cart",
                active: true
            },
            {
                header: "Clients",
                icon: "accounts",
                active: false
            },
            {
                header: "Rents",
                icon: "money-box",
                active: false
            },
            {
                header: "Reports",
                icon: "chart",
                active: false
            },
            {
                header: "Configuration",
                icon: "settings",
                active: false
            }
        ]
    },
    methods: {
        setMenuActive(e) {
            this.clearAllMenus();
            let value = e.target.getAttribute("data-value");
            this.menuList.filter((item) => {
                if (item.header === value) {
                    item.active = true;
                    this.setMenuContentActive(value.toLowerCase());
                }
            });
        },
        setMenuContentActive(menu) {
            document.querySelector("#" + menu).classList.add("active");
        },
        clearAllMenus() {
            this.menuList.forEach(element => {
                element.active = false;
            });
            document.querySelectorAll(".content").forEach(el => {
                el.classList.remove("active");
            });
        },
        changeRentStatus(e, id){
            fetch("http://localhost:53949/api/rents/"+id, {
                method: "PUT"
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                if(res.status === "ok"){
                    alert("RENT EDITED!");
                    this.refreshRentList();
                    e.target.selectedIndex = 0;
                }else{
                    alert("ERROR!!!");
                }
            });
        },
        addProduct(e){
            let context = this;

            if(!this.ValidateEntity("producto")){
                alert("YOU SHOULD BEHAVE YOURSELF!!!");
                return;
            }

            fetch("http://localhost:53949/api/products", {
                method: "POST",
                headers: {
                    "Accept": "application/json",
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(context.productAddModel)
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                if(res.status === "ok"){
                    alert("PRODUCT ADDED!");
                    this.hideModal(e);
                    this.refreshProductList();
                }else{
                    alert("ERROR!!!");
                }
            });
        },
        setEditProductView(item){
            this.productEditModel.IdProduct = item.IdProduct;
            this.productEditModel.Name = item.Name;
            this.productEditModel.Description = item.Description;
            this.productEditModel.Price = item.Price;
            this.productEditModel.Stock = item.Stock;
            this.productEditModel.Category = item.Category;
        },
        setEditCustomerView(item){
            this.customerEditModel.IdCustomer = item.IdCustomer;
            this.customerEditModel.DNI = item.DNI;
            this.customerEditModel.Firstname = item.Firstname;
            this.customerEditModel.Lastname = item.Lastname;
            this.customerEditModel.Address = item.Address;
            this.customerEditModel.Gender = item.Gender;
            this.customerEditModel.Phone = item.Phone;
        },
        editProduct(e){
            let context = this;
            let id = this.productEditModel.IdProduct;
            let url = "http://localhost:53949/api/products/"+id;

            fetch(url, {
                method: "PUT",
                headers: {
                    "Accept": "application/json",
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(context.productEditModel)
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                if(res.status === "ok"){
                    alert("PRODUCT EDITED!");
                    this.hideModal(e);
                    this.refreshProductList();
                }else{
                    alert("ERROR!!!");
                }
            });
        },
        deleteProduct(e){
            let id = this.productToDelete;
            let url =  "http://localhost:53949/api/products/"+id;
            fetch(url, {
                method: "DELETE",
                headers: {
                    "Accept": "application/json"
                }
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                if(res.status === "ok"){
                    alert("PRODUCT DELETED!");
                    this.hideModal(e);
                    this.refreshProductList();
                }else{
                    alert("ERROR!!!");
                }
            });
        },
        addCustomer(e){
            let context = this;

            if(!this.ValidateEntity("cliente")){
                alert("YOU SHOULD BEHAVE YOURSELF!!!");
                return;
            }

            fetch("http://localhost:53949/api/customers", {
                method: "POST",
                headers: {
                    "Accept": "application/json",
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(context.customerAddModel)
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                if(res.status === "ok"){
                    alert("CLIENT ADDED!");
                    this.hideModal(e);
                    this.refreshCustomerList();
                }else{
                    alert("ERROR!!!");
                }
            });
        },
        editCustomer(e){
            let context = this;
            let id = this.customerEditModel.IdCustomer;
            let url = "http://localhost:53949/api/customers/"+id;

            fetch(url, {
                method: "PUT",
                headers: {
                    "Accept": "application/json",
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(context.customerEditModel)
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                if(res.status === "ok"){
                    alert("CLIENT EDITED!");
                    this.hideModal(e);
                    this.refreshCustomerList();
                }else{
                    alert("ERROR!!!");
                }
            });
        },
        deleteCustomer(e){
            let id = this.customerToDelete;
            let url =  "http://localhost:53949/api/customers/"+id;
            fetch(url, {
                method: "DELETE",
                headers: {
                    "Accept": "application/json"
                }
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                if(res.status === "ok"){
                    alert("CLIENT DELETED!");
                    this.hideModal(e);
                    this.refreshCustomerList();
                }else{
                    alert("ERROR!!!");
                }
            });
        },
        refreshProductList(){
            this.productList = [];
            this.getProducts();
        },
        refreshCustomerList(){
            this.customerList = [];
            this.getCustomers();
        },
        refreshRentList(){
            this.rentsList = [];
            this.getRents();
        },
        reloadRents(){
            fetch("http://localhost:53949/api/rents/refresh", {
                method: "GET"
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                if(res.status === "ok"){
                    this.refreshRentList();
                }else{
                    alert("ERROR RENTS!!");
                }
            });
        },
        getProducts() {
            let context = this;
            fetch("http://localhost:53949/api/products", {
                    method: "GET",
                    Accept: "application/json"
                })
                .then((res) => {
                    return res.json();
                })
                .then((res) => {
                    res.forEach((item) => {
                        this.productList.push(item);
                    });
                    this.productList.forEach((el) => {
                        context.getImage(el.IdProduct, el.Name);
                    })
                });
        },
        getCustomers() {
            fetch("http://localhost:53949/api/customers", {
                    method: "GET",
                    Accept: "application/json"
                })
                .then((res) => {
                    return res.json();
                })
                .then((res) => {
                    res.forEach((item) => {
                        this.customerList.push(item);
                    });
                });
        },
        getRents() {
            fetch("http://localhost:53949/api/rents/view", {
                    method: "GET",
                    Accept: "application/json"
                })
                .then((res) => {
                    return res.json();
                })
                .then((res) => {
                    res.forEach((item) => {
                        this.rentsList.push(item);
                    });
                });
        },
        getRentsConfig(){
            fetch("http://localhost:53949/api/rentsConfig", {
                method: "GET",
                Accept: "application/json"
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                res.forEach((item) => {
                    this.rentConfigArray.push(item);
                });
            });
        },
        setRentsConfig(){
            this.rentConfig.tax = this.rentConfigArray.filter((item)=>{
                return item.Name === 'Tax'
            })[0].Value;
            this.rentConfig.finePerDay = this.rentConfigArray.filter((item)=>{
                return item.Name === 'DuePerDay'
            })[0].Value;
        },
        saveRentConfigTunnel(){
            this.saveRentConfig("tax");
            this.saveRentConfig("fine");
        },
        saveRentConfig(config){
            let url = "";
            let item = null;

            if(config === "tax"){
                url = "http://localhost:53949/api/rentsConfig/1";
                item = {
                    "Value": this.rentConfig.tax
                };
            }else if(config === "fine"){
                url = "http://localhost:53949/api/rentsConfig/3";
                item = {
                    "Value": this.rentConfig.finePerDay
                };
            }

            fetch(url, {
                method: "PUT",
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(item)
            })
            .then((res) => {
                return res.json();
            })
            .then((res) => {
                if(res.status === "ok"){
                    alert("CONFIGURATION SAVED!");
                }
            });
        },
        addToCheckout(idProduct) {
            let product = this.productList.filter((item) => {
                if (item.IdProduct === idProduct) {
                    return item;
                }
            })[0];

            let cont = true;

            this.checkoutList.filter((el) => {
                if (el.IdProduct === product.IdProduct) {
                    cont = false;
                }
            });

            if (!cont) {
                return;
            }

            let checkOutObject = {
                IdProduct: product.IdProduct,
                ProductName: product.Name,
                ProductPrice: product.Price,
                ProductQuantity: 1
            };

            this.checkoutList.push(checkOutObject);
            this.updateCheckoutDetails();
        },
        removeFromCheckout(idProduct) {
            this.checkoutList.splice(
                this.checkoutList.indexOf(
                    this.checkoutList.filter((item) => {
                        return item.IdProduct === idProduct
                    })[0]
                ),
                1
            );
            this.updateCheckoutDetails();
        },
        addQuantityCheckOut(idProduct) {
            this.checkoutList.filter((item) => {
                if (item.IdProduct === idProduct) {
                    item.ProductQuantity += 1
                }
            });
            this.updateCheckoutDetails();
        },
        removeQuantityCheckOut(idProduct) {
            this.checkoutList.filter((item) => {
                if (item.IdProduct === idProduct) {
                    if (item.ProductQuantity === 1) {
                        return;
                    } else {
                        item.ProductQuantity -= 1
                    }
                }
            });
            this.updateCheckoutDetails();
        },
        updateCheckoutDetails() {
            let itbis = this.rentConfig.tax;
            let discount = 0;
            let subtotal = 0;
            let date1 = new Date();
            //let parsedDate1 = date1.getFullYear() + "-" + this.paddNumber(date1.getMonth() + 1) + "-" + (date1.getDate());
            let date2 = new Date(this.checkOutDetails.returnDate);
            let days = Math.ceil((date2 - date1) / (1000 * 60 * 60 * 24));
            if (days === 0) {
                days = 1;
            }

            this.checkoutList.map((item, index) => {
                subtotal += (item.ProductPrice * item.ProductQuantity)
            });

            subtotal = subtotal * days;

            let tax = subtotal * itbis;
            let total = subtotal + tax - discount;

            this.checkOutDetails.discount = discount.toFixed(2);
            this.checkOutDetails.subtotal = subtotal.toFixed(2);
            this.checkOutDetails.tax = tax.toFixed(2);
            this.checkOutDetails.total = total.toFixed(2);
        },
        paddNumber(num) {
            return (num < 10 ? '0' : '') + num;
        },
        setReturnDateToCheckOut() {
            let date = this.addDays(1);            
            let parsedDate = date.getFullYear() + "-" + this.paddNumber(date.getMonth() + 1) + "-" + this.paddNumber(date.getDate());
            this.checkOutDetails.returnDate = parsedDate;
        },
        getToday() {
            let date = new Date();
            let parsedDate = date.getFullYear() + "-" + this.paddNumber(date.getMonth() + 1) + "-" + (date.getDate());
            return parsedDate;
        },
        showModal(e) {
            let target = e.target.getAttribute("data-target");
            let targetShadow = target + "Shadow";
            document.querySelector("#" + target).classList.add("active");
            document.querySelector("#" + targetShadow).classList.add("active");
        },
        hideModal(e) {
            let target = e.target.getAttribute("data-target");
            let targetShadow = target + "Shadow";
            document.querySelector("#" + target).classList.remove("active");
            document.querySelector("#" + targetShadow).classList.remove("active");
        },
        setCheckOutCustomer(e, id) {
            this.checkOutDetails.idCustomer = id;
            this.hideModal(e);
        },
        clearCheckOutCustomer() {
            this.checkOutDetails.idCustomer = -1;
        },
        getCustomerFullName(id) {
            let fullName = "";
            if (id > 0) {
                let cust = this.customerList.filter((item) => {
                    return item.IdCustomer === id
                })[0];
                fullName = cust.Firstname + " " + cust.Lastname;
            }
            return fullName;
        },
        getImage(idProduct, query) {
            let context = this;
            let image = "https://image.tmdb.org/t/p/w500";
            let url = "https://api.themoviedb.org/3/search/movie?api_key=49235647fdc2b532e1a7e8c961cf60e5&query=" + query;

            fetch(url, {
                    method: "GET"
                })
                .then((res) => {
                    return res.json();
                })
                .then((res) => {
                    if (res.results.length > 0) {
                        image = image + res.results[0].poster_path;
                        context.productList.filter((item) => {
                            return item.IdProduct === idProduct
                        })[0].Poster = image;
                    }
                });
        },
        sendInvoice() {

            if (!this.validateEverything()) {
                alert("You should behave yourself!");
                return;
            }

            let context = this;
            fetch("http://localhost:53949/api/rents", {
                    method: "POST",
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        "IdCustomer": context.checkOutDetails.idCustomer,
                        "Date": context.getToday(),
                        "ReturnDate": context.checkOutDetails.returnDate
                    })
                })
                .then((res) => {
                    return res.json();
                })
                .then((res) => {
                    if (res.status === "ok") {
                        context.sendInvoiceDetails(parseInt(res.idRent));
                    } else {
                        alert("There was an error generating the receipt");
                        alert(context.checkOutDetails.returnDate)
                        return;
                    }
                })
        },
        sendInvoiceDetails(idRent) {
            let item = {
                "IdRent": idRent,
                "rentalRows": this.checkoutList
            };

            console.log(item);

            fetch("http://localhost:53949/api/RentsDetail", {
                    method: "POST",
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(item)
                })
                .then((res) => {
                    return res.json();
                })
                .then((res) => {
                    if (res.status === "ok") {
                        alert("OK!!!");
                    }
                })
        },
        validateEverything() {
            let result = true;

            if (this.checkoutList.length === 0) {
                result = false;
            }

            if (this.checkOutDetails.idCustomer === -1) {
                result = false;
            }

            if (this.checkOutDetails.returnDate === "") {
                result = false;
            }

            return result;
        },
        clearReceipt() {
            this.checkoutList = [];
            this.clearCheckOutCustomer();
            this.checkOutDetails.discount = 0.00;
            this.checkOutDetails.tax = 0.00;
            this.checkOutDetails.subtotal = 0.00;
            this.checkOutDetails.total = 0.00;
            this.checkOutDetails.idCustomer = -1;
            this.setReturnDateToCheckOut();
        },
        addDays(days) {
            return new Date(Date.now() + 864e5 * days);
        },
        ValidateEntity(type){
            let result = true;
            let arr = null;

            switch(type){
                case "producto":
                    arr = Object.values(this.productAddModel);
                    for(let item of arr){
                        if(item === "" || item === undefined){
                            result = false;
                        }
                    }
                break;
                case "cliente":
                    arr = Object.values(this.customerAddModel);
                    for(let item of arr){
                        if(item === "" || item === undefined){
                            result = false;
                        }
                    }
                break;
            }

            return result;
        }
    },
    computed: {
        filteredProducts() {
            if (this.searchProducts.length > 0) {
                return this.productList.filter((item) => {
                    return(
                        item.Name.indexOf(this.searchProducts) > -1 ||
                        item.Category.indexOf(this.searchProducts) > -1 ||
                        item.Price.toString().indexOf(this.searchProducts) > -1
                    )
                });
            } else {
                return this.productList;
            }
        },
        filteredCustomers(){
            if (this.searchCustomers.length > 0) {
                return this.customerList.filter((item) => {
                    return(
                        item.DNI.indexOf(this.searchCustomers) > -1 ||
                        item.Firstname.indexOf(this.searchCustomers) > -1 ||
                        item.Lastname.indexOf(this.searchCustomers) > -1 ||
                        item.Address.indexOf(this.searchCustomers) > -1 ||
                        item.Gender.indexOf(this.searchCustomers) > -1 ||
                        item.Phone.indexOf(this.searchCustomers) > -1
                    )
                });
            } else {
                return this.customerList;
            }
        },
        filteredRents(){
            if (this.searchRents.length > 0) {
                return this.rentsList.filter((item) => {
                    return(
                        item.IdRent.toString().indexOf(this.searchRents) > -1 ||
                        item.Customer.indexOf(this.searchRents) > -1 ||
                        item.Date.indexOf(this.searchRents) > -1 ||
                        item.ReturnDate.indexOf(this.searchRents) > -1 ||
                        item.Status.indexOf(this.searchRents) > -1 ||
                        item.TotalAmount.toString().indexOf(this.searchRents) > -1 ||
                        item.DueAmount.toString().indexOf(this.searchRents) > -1
                    )
                });
            } else {
                return this.rentsList;
            }
        },
        filteredCustomersModal() {
            if (this.searchCustomersModal.length > 0) {
                return this.customerList.filter((item) => {
                    let fullName = item.Firstname + " " + item.Lastname;

                    return (
                        item.DNI.indexOf(this.searchCustomersModal) > -1 ||
                        fullName.indexOf(this.searchCustomersModal) > -1
                    )
                })
            } else {
                return this.customerList;
            }
        }
    },
    mounted: function() {
        this.getProducts();
        this.getCustomers();
        this.setReturnDateToCheckOut();
        this.getRents();
    }
});