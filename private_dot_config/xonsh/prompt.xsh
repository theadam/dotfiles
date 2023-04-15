from xonsh.built_ins import XSH
from xonsh.events import events
from xonsh.prompt.vc import git_dirty_working_directory
import builtins
import re
import os
from prompt_toolkit.keys import Keys


_lastcommand = None

def _return_color():
    if XSH.env.get('LAST_RETURN_CODE', 0) or None:
        return '{RED}'
    else: 
        return '{GREEN}'


def _lastcommandtime():
  try: 
    if _lastcommand is not None and getattr(_lastcommand, 'starttime') and getattr(_lastcommand, 'endtime'):
      return human_time_duration((_lastcommand.endtime - _lastcommand.starttime)*1000)
  except:
    pass
  return None


$PROMPT_FIELDS['branch_color'] = lambda: ('{RED}' if git_dirty_working_directory() else '{GREEN}')
$PROMPT_FIELDS['env_prefix'] = ''
$PROMPT_FIELDS['env_postfix'] = ''
$PROMPT_FIELDS['return_color'] = _return_color
$PROMPT_FIELDS['lastcommandtime'] = _lastcommandtime
$PROMPT = """
{BLUE}{cwd_dir}{CYAN}{cwd_base}{branch_color}{curr_branch: {}}{RESET} {RED}{last_return_code_if_nonzero:[{BOLD_INTENSE_RED}{}{RED}] }{RESET}{#444444}{fill} {#81815b}{lastcommandtime}{RESET}
{return_color}❯{RESET} """

transient_prompt = '{return_color}❯{RESET} '

fill_char = '─'

def strip_special(str):
  return re.sub(r'\{.*?\}', '', str)
  

def fill_processor(tokens):
  """
  A prompt tokens formatter that handles {fill} values
  """
  res = "".join([tok.value for tok in tokens.tokens])
  lines = res.split('\n')
  replaced_lines = []
  for line in lines:
    sections = line.split('{fill}')
    section_count = len(sections)

    if section_count == 1:
      replaced_lines.append(line)
      continue

    width = os.get_terminal_size().columns
    missing_space = width - sum([len(strip_special(s)) for s in sections])

    each_fill_count = ((missing_space - 1) / (section_count - 1))
    fill = fill_char * int(each_fill_count)


    replaced_lines.append(fill.join(sections))
  return '\n'.join(replaced_lines)

$PROMPT_TOKENS_FORMATTER = fill_processor

def prompt_tokens(prompt: str) -> str:
  """
  Get the tokens from a given prompt string
  """
  from xonsh.ptk_shell.shell import tokenize_ansi
  from prompt_toolkit.formatted_text import PygmentsTokens
  from xonsh.style_tools import partial_color_tokenize

  formatted = XSH.shell.prompt_formatter(prompt)
  return tokenize_ansi(PygmentsTokens(partial_color_tokenize(formatted)))

@events.on_submit_command
def handle_transient_prompt(buffer, cli):
  """
  When a command is submitted, briefly immediately change the prompt to the transient version 
  """
  from xonsh.ptk_shell.shell import tokenize_ansi
  from prompt_toolkit.formatted_text import PygmentsTokens
  from xonsh.style_tools import partial_color_tokenize

  formatted = XSH.shell.prompt_formatter(transient_prompt)
  tokens = tokenize_ansi(PygmentsTokens(partial_color_tokenize(formatted)))

  XSH.shell.prompter.message = tokens
  XSH.shell.prompter.app.invalidate()
  _lastcommand = None

#@events.on_pre_cmdloop
def set_lastcommand(*args, **kwargs):
  try:
    _lastcommand = getattr(builtins, '_')
  except:
    pass

TIME_DURATION_UNITS = (
    ('w', 1000*60*60*24*7),
    ('d', 1000*60*60*24),
    ('h', 1000*60*60),
    ('m', 1000*60),
    ('s', 1000)
    #('ms', 1)
)

def human_time_duration(seconds):
    if seconds == 0:
        return 'inf'
    parts = []
    for unit, div in TIME_DURATION_UNITS:
        amount, seconds = divmod(int(seconds), div)
        if amount > 0:
            parts.append('{}{}'.format(amount, unit))
    return ' '.join(parts)

@events.on_ptk_create
def custom_keybindings(bindings, **kw):
    pattern = re.compile(r"([a-zA-Z0-9]+|[^a-zA-Z0-9_\s]+)")

    def find_next_word_ending(
        self
    ) -> int | None:
        """
        Return an index relative to the cursor position pointing to the end
        of the next word. Return `None` if nothing was found.
        """
        text = self.text_after_cursor[1:]

        iterable = pattern.finditer(text)

        try:
            match = next(iterable)
            value = match.end(1)
            return value + 1

        except StopIteration:
            pass
        return None

    @bindings.add("escape", "b")
    def back_word(event):
        buff = event.current_buffer
        pos = buff.document.find_start_of_previous_word(count=event.arg, pattern=pattern)

        if pos:
            buff.cursor_position += pos

    @bindings.add("escape", "f")
    def forward_word(event):
        buff = event.current_buffer
        pos = find_next_word_ending(buff.document)

        if pos:
            buff.cursor_position += pos

    @bindings.add("escape", "backspace")
    def kill_word(event):
        """
        Kill the word behind point, using whitespace as a word boundary.
        Usually bound to ControlW.
        """
        buff = event.current_buffer
        pos = buff.document.find_start_of_previous_word(count=event.arg, pattern=pattern)
    
        if pos is None:
            # Nothing found? delete until the start of the document.  (The
            # input starts with whitespace and no words were found before the
            # cursor.)
            pos = -buff.cursor_position
    
        if pos:
            deleted = buff.delete_before_cursor(count=-pos)
    
            # If the previous key press was also Control-W, concatenate deleted
            # text.
            if event.is_repeat:
                deleted += event.app.clipboard.get_data().text
    
            event.app.clipboard.set_text(deleted)
        else:
            # Nothing to delete. Bell.
            event.app.output.bell()
      


