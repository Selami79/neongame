// Setup when page loads
window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);
    const player_name = urlParams.get('player');

    if (player_name) {
        // If player name is in URL, auto-fill and lock input
        var input = document.getElementById('playerName');
        if (input) {
            input.value = player_name;
            input.readOnly = true;
            input.style.borderColor = "#0f0";
            input.style.color = "#0f0";
        }
    }
};

function submitToSL() {
    var name = document.getElementById('playerName').value;
    if (!name) { alert("Please enter your name!"); return; }

    // Get SL URL from query parameters
    const urlParams = new URLSearchParams(window.location.search);
    const sl_url = urlParams.get('sl_url');

    if (sl_url) {
        var data = JSON.stringify({
            "name": name,
            "score": score
        });

        fetch(sl_url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: data
        }).then(response => {
            // alert("Score Submitted!"); 
            // In-game visual feedback instead of popup
            var btn = document.querySelector("#slInputArea button");
            if (btn) {
                btn.innerHTML = "✅ SENT!";
                btn.style.background = "#0f0";
                btn.disabled = true;
            }
        }).catch(error => {
            console.error("SL Error:", error);
            alert("Connection Error. Try again.");
        });
    } else {
        alert("Offline Mode: Score cannot be saved to SL.");
    }
}
