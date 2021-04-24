from pathlib import (
    WindowsPath,
    Path
)

def write_sql_to_file(comment: str, query: str, path: WindowsPath) -> None:
    """
    Appends the query and comment to a file on disk
    :param comment:
    :param query:
    :param path:
    :return:
    """
    with open(path, 'a+') as f:
        f.write(f'-- {comment}')
        f.write(query)
