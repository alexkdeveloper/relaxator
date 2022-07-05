icon_sizes = ['32', '48', '64', '128']

foreach i : icon_sizes
    install_data(
        join_paths('icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
    )
    install_data(
        join_paths('icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i + '@2', 'apps')
    )
endforeach

i18n.merge_file(
    input: meson.project_name() + '.desktop.in',
    output: meson.project_name() + '.desktop',
    po_dir: join_paths(meson.source_root(), 'po', 'extra'),
    type: 'desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

i18n.merge_file(
    input: meson.project_name() + '.appdata.xml.in',
    output: meson.project_name() + '.appdata.xml',
    po_dir: join_paths(meson.source_root(), 'po', 'extra'),
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

install_data(
    join_paths('images', 'waves.svg'),
    install_dir : join_paths('share', 'Relaxator', 'images'))

install_data(
    join_paths('images', 'forest.svg'),
    install_dir : join_paths('share', 'Relaxator', 'images'))

install_data(
    join_paths('images', 'night.svg'),
    install_dir : join_paths('share', 'Relaxator', 'images'))

install_data(
    join_paths('images', 'rain.svg'),
    install_dir : join_paths('share', 'Relaxator', 'images'))

install_data(
    join_paths('images', 'fire.svg'),
    install_dir : join_paths('share', 'Relaxator', 'images'))

install_data(
    join_paths('images', 'cat.svg'),
    install_dir : join_paths('share', 'Relaxator', 'images'))

install_data(
    join_paths('sounds', 'waves.ogg'),
    install_dir : join_paths('share', 'Relaxator', 'sounds'))

install_data(
    join_paths('sounds', 'forest.ogg'),
    install_dir : join_paths('share', 'Relaxator', 'sounds'))

install_data(
    join_paths('sounds', 'night.ogg'),
    install_dir : join_paths('share', 'Relaxator', 'sounds'))

install_data(
    join_paths('sounds', 'rain.ogg'),
    install_dir : join_paths('share', 'Relaxator', 'sounds'))

install_data(
    join_paths('sounds', 'fire.ogg'),
    install_dir : join_paths('share', 'Relaxator', 'sounds'))

install_data(
    join_paths('sounds', 'cat.ogg'),
    install_dir : join_paths('share', 'Relaxator', 'sounds'))