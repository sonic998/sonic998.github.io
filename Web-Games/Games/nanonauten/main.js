let toggle = false;
function OpenShop()
{
    if (!toggle)
    {
        document.getElementById('InvisBtn1').className = "Btn";
        document.getElementById('InvisBtn2').className = "Btn";
        toggle = true
    }
    else if (toggle)
    {
        document.getElementById('InvisBtn1').className = "InvisBtn";
        document.getElementById('InvisBtn2').className = "InvisBtn";
        toggle = false
    }
}

let canbuy = true;
function buy(type)
{
    if (type === 1 && localStorage.getItem('scoregoal') >= 200)
    {
        let health = parseInt(localStorage.getItem('gezondheid'));
        let scoregoal = parseInt(localStorage.getItem('scoregoal'));
        if (scoregoal >= 199)
        {
            canbuy = true;
        }
        if (scoregoal === 100)
        {
            canbuy = false;
        }
        if (canbuy === true)
        {
            localStorage.setItem('scoregoal', scoregoal -= 200);
            localStorage.setItem("gezondheid", health += 50);
        }
    }
    if (type === 2 && localStorage.getItem('scoregoal') >= 400)
    {
        let health = parseInt(localStorage.getItem('gezondheid'));
        let scoregoal = parseInt(localStorage.getItem('scoregoal'));
        if (scoregoal >= 399)
        {
            canbuy = true;
        }
        if (scoregoal === 300)
        {
            canbuy = false;
        }
        if (canbuy === true)
        {
            localStorage.setItem('scoregoal', scoregoal -= 400);
            localStorage.setItem("gezondheid", health += 100);
        }
    }
}