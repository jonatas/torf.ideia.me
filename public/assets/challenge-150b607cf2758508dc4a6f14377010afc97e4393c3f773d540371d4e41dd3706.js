(function() {
  var AnswerTimeout;

  this.Game = (function() {
    function Game() {
      this.startAt = new Date();
      this.answers = [];
      this.success = 0;
      this.fails = 0;
      this.answerTime = 0;
      this.timeouted = 0;
    }

    Game.prototype.setup = function() {
      $(".setup").show();
      $("#torf_buttons").hide();
      return $("#btn-ok").show();
    };

    Game.prototype.ack = function() {
      $(".setup pre").css('line-height', '1.0');
      $(".setup pre").css('display', 'contents');
      $(".setup pre").css('padding', '0px');
      $(".setup pre").css('margin-left', '20px');
      $(".setup pre").css('font-size', '10px');
      $(".setup pre").css('margin-top', '0px');
      $(".setup pre").css('margin-bottom', '0px');
      $("#btn-ok").hide();
      return game.start();
    };

    Game.prototype.start = function() {
      this.timeout = new AnswerTimeout(1000);
      this.currentChallenge = $(".challenge:first");
      this.currentChallenge.show();
      $("#torf_buttons").show();
      return this.timeout.start();
    };

    Game.prototype.answer = function(user_input) {
      var rightOrWrong;
      rightOrWrong = user_input === this.currentChallenge.attr('answer');
      this.answers.push(rightOrWrong);
      if (this.lastAnswer != null) {
        this.answerTime += (new Date()).getTime() - this.lastAnswer.getTime();
      }
      this.lastAnswer = new Date();
      this.nextChallenge(rightOrWrong);
      return this.updateStatus();
    };

    Game.prototype.updateStatus = function() {
      $("#answer-number").text(this.currentChallenge.attr('sequence'));
      $("#timeout").text(this.timeout.time);
      return $("#status").html(this.status());
    };

    Game.prototype.nextChallenge = function(rightOrWrong) {
      var nextChallenge;
      this.classifyAnswer(rightOrWrong);
      this.currentChallenge.hide();
      nextChallenge = this.currentChallenge.next('.challenge');
      if ((nextChallenge != null) && nextChallenge.length > 0) {
        nextChallenge.show();
        this.timeout.cancel();
        this.timeout = new AnswerTimeout(100 + this.timeout.time);
        this.currentChallenge = nextChallenge;
        return this.timeout.start();
      } else {
        return this.finishGame();
      }
    };

    Game.prototype.status = function() {
      return "<span class='badge'> ✅ " + this.success + "</span> \n<span class='badge'> ❌ " + this.fails + "</span>\n<span class='badge'> ⌛️ " + this.timeouted + "</span>";
    };

    Game.prototype.eachTimeoutSecond = function() {
      return this.updateStatus();
    };

    Game.prototype.timeFromStart = function() {
      return ((new Date()).getTime() - this.startAt.getTime()) / 1000;
    };

    Game.prototype.onAnswerTimeout = function() {
      return this.nextChallenge(null);
    };

    Game.prototype.finishGame = function() {
      var challenge, failChallenges, j, language, len, msg;
      this.timeout.cancel();
      $(".challenge").hide();
      $(".buttons").hide();
      failChallenges = $(".challenge[user_answer=wrong]");
      if (failChallenges.length > 0) {
        msg = "<h1>Review your " + failChallenges.length + " fails</h1>";
        failChallenges.show();
        for (j = 0, len = failChallenges.length; j < len; j++) {
          challenge = failChallenges[j];
          challenge = $(challenge);
          challenge.find('.code pre').append("<span class='timeouted'> # => " + (challenge.attr('answer')) + "</span>");
          challenge.find('.hint').show();
        }
      } else {
        language = $("#challenge").attr('language');
        msg = "You are a true " + language + " compiler! Congratulations!";
      }
      $(".challenge:first").before($(msg));
      return this.sendScore();
    };

    Game.prototype.sendScore = function() {
      return $.ajax({
        url: "/scores.json",
        type: "POST",
        data: {
          score: {
            challenge_id: $("#challenge").val(),
            right: this.success,
            wrong: this.fails,
            timed_out: this.timeouted
          }
        }
      });
    };

    Game.prototype.classifyAnswer = function(rightOrWrong) {
      var _class;
      if (rightOrWrong === null) {
        this.timeouted += 1;
        _class = 'timeouted glyphicon glyphicon-time';
      } else if (rightOrWrong === true) {
        this.success += 1;
        _class = 'right glyphicon glyphicon-ok';
      } else {
        this.fails += 1;
        _class = 'wrong glyphicon glyphicon-remove';
      }
      this.currentChallenge.attr('user_answer', _class.split(' ')[0]);
      return $(".answers").append($("<span class='" + _class + "'></span>"));
    };

    return Game;

  })();

  AnswerTimeout = (function() {
    function AnswerTimeout(time) {
      this.time = time != null ? time : 10;
    }

    AnswerTimeout.prototype.cancel = function() {
      this.canceled = true;
      return clearTimeout(this.timeoutId);
    };

    AnswerTimeout.prototype.start = function() {
      var countdown;
      this.time -= 1;
      countdown = function(i) {
        game.timeout.time = i;
        if (game.timeout.time < 3) {
          game.currentChallenge.find('.hint').show();
        }
        if (i < 0) {
          game.onAnswerTimeout();
        } else {
          if (this.canceled == null) {
            game.timeout.timeoutId = setTimeout(countdown.bind(this), 1000, i - 1);
          }
        }
        return game.eachTimeoutSecond(i);
      };
      return game.timeout.timeoutId = countdown.bind(this)(this.time);
    };

    return AnswerTimeout;

  })();

  $(function() {
    if ($(".challenge").length > 0) {
      window.game = new Game();
      game.setup();
      $('#btn-ok').on('touchend click', function(event) {
        event.stopPropagation();
        event.preventDefault();
        return game.ack();
      });
      return $('#btn-true,#btn-false').on('touchend click', function(event) {
        event.stopPropagation();
        event.preventDefault();
        return game.answer(this.value);
      });
    }
  });

}).call(this);
