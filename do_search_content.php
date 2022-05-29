<?php
require_once "init.php";
require_once "api_keys.php";
header("Content-Type: application/json; charset=UTF-8");
$conn = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, "hw1_db", "3306");
if (isset($_SESSION["UID"])) {
    $escapedPassword = mysqli_escape_string($conn, $_SESSION['userid']);
    $escapedUser = mysqli_escape_string($conn, $_SESSION['username']);
    $query = "SELECT username from hw1_users where password = '{$escapedPassword}' and username = '{$escapedUser}'";
    $queryRes = mysqli_query($conn, $query);

    if ($queryRes) {
        if (mysqli_num_rows($queryRes) == 0) {
            session_unset();
            session_destroy();
            mysqli_free_result($queryRes);
            mysqli_close($conn);
            header("Location: {$uri}/../login.php");
            exit();
        }
        mysqli_free_result($queryRes);
    } else {
        mysqli_close($conn);
        header("Location: {$uri}/../login.php");
        exit();
    }

} else {
    mysqli_close($conn);
    header("Location: {$uri}/../login.php");
    exit();
}

if (!isset($_POST["service_select"]) || ($_POST["service_select"] != "TMDB" && $_POST["service_select"] != "GoogleBooks")) {
    echo "321";
    exit();
}
if (isset($_POST["search_query"]) && empty(trim( $_POST["search_query"]))) {
    echo "321";
    exit();
}


function YoutubeSearch_proc($search_query) {
    $curl_handler = curl_init();
    $encodedSearch = curl_escape($curl_handler, $search_query);
    $yt_url_search = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=12&q={$encodedSearch}&type=video&key=AIzaSyDyBxDAebdk1b9C6IUXSgde2Ugx_CpP6Qw";
    curl_setopt($curl_handler, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl_handler, CURLOPT_URL, $yt_url_search);
    $res = curl_exec($curl_handler);
    curl_close($curl_handler);

    echo $res;
}




function Film_search($search_query) {
    $curl_handler = curl_init();
    $encodedSearch = curl_escape($curl_handler, $search_query);
    $tmdb_url = "https://api.themoviedb.org/3/search/movie?api_key=" . API_KEY_TMDB . "&query=" . $encodedSearch;
    curl_setopt($curl_handler, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl_handler, CURLOPT_URL, $tmdb_url);
    $res = curl_exec($curl_handler);
    curl_close($curl_handler);

    echo $res;
}

$service = $_POST["service_select"];

if ($service == "TMDB") {

    $search_query = trim($_POST["search_query"]);
    Film_search($search_query);
} else {
    $search_query = trim($_POST["search_query"]);
    YoutubeSearch_proc($search_query);
}